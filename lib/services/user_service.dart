import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'friend_code_service.dart';
import '../models/friend.dart';
import 'package:rxdart/rxdart.dart';

final _firestore = FirebaseFirestore.instance;
var logger = Logger();

class UserService {
  Future<void> createUserWithFriendCodeInFirestore(
    String uid,
    String email,
  ) async {
    logger.d('Checking if user already exists in Firestore with UID: $uid');

    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (userDoc.exists) {
      logger.d('User already exists in Firestore for UID: $uid');
      return; // stop here, no need to recreate
    }
    ('Creating user in Firestore with UID: $uid');
    String friendCode = await generateUniqueFriendCode(uid);
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'displayName': email.split('@').first,
      'createdAt': FieldValue.serverTimestamp(),
      'friendCode': friendCode,
    });
    logger.d('Storing friend code: $friendCode');
    await _firestore.collection('friendCodes').doc(friendCode).set({
      'uid': uid,
    });

    logger.d('User document created in Firestore for UID: $uid');
  }

  Future<DocumentSnapshot> getUserDoc(String uid) async {
    return _firestore.collection('users').doc(uid).get();
  }

  Stream<List<Friend>> getFriendsStream(String uid) {
    final userDoc = _firestore.collection('users').doc(uid);

    // Stream of normal friends UIDs
    final Stream<QuerySnapshot<Map<String, dynamic>>> friendsStream = userDoc
        .collection('friends')
        .snapshots();

    // Stream of manual friends
    final Stream<QuerySnapshot<Map<String, dynamic>>> manualFriendsStream =
        userDoc.collection('manualFriends').snapshots();

    // Combine both streams
    return Rx.combineLatest2(friendsStream, manualFriendsStream, (
      QuerySnapshot<Map<String, dynamic>> qsFriends,
      QuerySnapshot<Map<String, dynamic>> qsManualFriends,
    ) async {
      List<Friend> friendsList = [];

      // Normal friends: fetch each user's document
      final normalFriendsFutures = qsFriends.docs.map((doc) async {
        final friendDoc = await _firestore
            .collection('users')
            .doc(doc.id)
            .get();
        return Friend.fromUserDoc(friendDoc);
      }).toList();

      final normalFriends = await Future.wait(normalFriendsFutures);
      friendsList.addAll(normalFriends);

      // Manual friends
      final manualFriends = qsManualFriends.docs
          .map((doc) => Friend.fromManualFriendDoc(doc))
          .toList();
      friendsList.addAll(manualFriends);

      return friendsList;
    }).asyncMap(
      (futureList) => futureList,
    ); // convert Future<List> -> Stream<List>
  }
}
