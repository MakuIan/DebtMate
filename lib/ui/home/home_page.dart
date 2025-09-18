import 'package:debtmate/ui/home/widgets/add_friends_box.dart';
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
            Flexible(
              flex: 2,
              child: Container(
                height: 350,
                width: 350,
                margin: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: const Center(child: Text('Main Content Area')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
