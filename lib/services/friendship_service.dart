import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
var logger = Logger();

class AddFriendResult {
  final bool success;
  final String? message;

  AddFriendResult.success([this.message]) : success = true;
  AddFriendResult.failure(this.message) : success = false;
}

class FriendshipService {
  Future<AddFriendResult> addFriendViaFriendCode(
    String friendCode,
    String uid,
  ) async {
    try {
      DocumentSnapshot friendCodeDoc = await _firestore
          .collection('friendCodes')
          .doc(friendCode)
          .get();

      String friendUid = friendCodeDoc.get('uid');
      DocumentSnapshot friendDoc = await _firestore
          .collection('users')
          .doc(friendUid)
          .get();
      String friendDisplayName = friendDoc.get('displayName');

      if (friendCodeDoc.exists) {
        if (friendUid == uid) {
          logger.d("That's your own friend Code!");
          return AddFriendResult.failure(
            "That's your own friend Code! You can't add yourself",
          );
        }
        await _firestore.doc('users/$uid/friends/$friendUid').set({
          'addedAt': FieldValue.serverTimestamp(),
        });
        await _firestore.doc('users/$friendUid/friends/$uid').set({
          'addetAT': FieldValue.serverTimestamp(),
        });
        logger.d('Found a User with friend code $friendCode');
        return AddFriendResult.success(
          'Successfully added $friendDisplayName as a friend',
        );
      }
      logger.d('No User found with friend code $friendCode');
      return AddFriendResult.failure('No User found');
    } catch (e) {
      logger.d('Error getting FriendCode Document: $e');
      return AddFriendResult.failure('Error getting FriendCode Document: $e');
    }
  }

  Future<AddFriendResult> addManualyCreatedFriend(
    String uid,
    String friendName,
  ) async {
    logger.d(
      'Adding $friendName to the users/$uid/manualFriends Subcollection',
    );
    try {
      await _firestore.collection('users/$uid/manualFriends/').add({
        'displayName': friendName,
        'addedAt': FieldValue.serverTimestamp(),
      });
      return AddFriendResult.success('Successfully created Friend');
    } catch (e) {
      logger.d('Error creating Manual Friend: $e');
      return AddFriendResult.failure('Error creating Manual Friend $e');
    }
  }
}
