import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:logger/logger.dart';

final _firestore = FirebaseFirestore.instance;
var logger = Logger();

Future<void> createUserWithFriendCodeInFirestore(
  String uid,
  String email,
) async {
  ('Creating user in Firestore with UID: $uid');
  String friendCode = await generateUniqueFriendCode(uid);
  await _firestore.collection('users').doc(uid).set({
    'email': email,
    'createdAt': FieldValue.serverTimestamp(),
    'friendCode': friendCode,
  });
  logger.d('Storing friend code: $friendCode');
  await _firestore.collection('friendCodes').doc(friendCode).set({'uid': uid});

  logger.d('User document created in Firestore for UID: $uid');
}

Future<String> generateUniqueFriendCode(String uid) async {
  logger.d('Generating unique friend code');
  final friendCodeCollection = _firestore.collection('friendCodes');
  String code;
  bool exists = true;

  do {
    code = generateFriendCode();
    final doc = await friendCodeCollection.doc(code).get();
    exists = doc.exists;
  } while (exists);
  return code;
}

String generateFriendCode([int length = 6]) {
  logger.d('Generating friend code of length $length');
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(
    length,
    (index) => chars[rand.nextInt(chars.length)],
  ).join();
}
