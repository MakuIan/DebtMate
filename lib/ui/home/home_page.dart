import 'package:debtmate/ui/home/widgets/add_friends_box.dart';
import 'package:debtmate/ui/home/widgets/friend_list.dart';
import 'package:debtmate/ui/nav/nav_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/home_page_header.dart';
import '../../services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(
      backgroundColor: const Color.fromARGB(255, 0, 126, 244),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 126, 244),
                Color.fromARGB(255, 0, 126, 244),
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.8, 0.8, 1.0],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              FutureBuilder<DocumentSnapshot>(
                future: UserService().getUserDoc(_auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return HomePageHeader(userDoc: snapshot.data!);
                },
              ),
              const AddFriendsBox(),
              FriendList(),
            ],
          ),
        ),
      ),
    );
  }
}
