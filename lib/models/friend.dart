import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String? uid;
  final DateTime createdAt;
  final String displayName;
  final String? email;
  final String? friendCode;
  final bool isManual;

  Friend({
    this.uid,
    required this.createdAt,
    required this.displayName,
    this.email,
    this.friendCode,
    this.isManual = false,
  });

  factory Friend.fromUserDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Friend(
      uid: doc.id,
      displayName:
          data['displayName'] as String? ?? 'Unknown', // fallback if null
      email: data['email'] as String? ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(), // fallback if null
      friendCode: data['friendCode'] as String? ?? '',
      isManual: false,
    );
  }

  factory Friend.fromManualFriendDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return Friend(
      uid: doc.id,
      displayName: data['displayName'] as String? ?? 'Unknown',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      isManual: true,
    );
  }
}
