import 'dart:math';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
var logger = Logger();

Future<String> generateUniqueFriendCode(String uid) async {
  logger.d('Generating unique friend code');
  final friendCodeCollection = _firestore.collection('friendCodes');
  String code;
  bool exists = true;

  do {
    code = generateFriendCode();
    final doc = await friendCodeCollection.doc(code).get();
    exists = doc.exists;
    logger.d(exists ? 'Friend Code $code exists' : 'Storing Friend Code $code');
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
