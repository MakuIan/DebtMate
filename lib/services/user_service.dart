import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'friend_code_service.dart';

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
}
