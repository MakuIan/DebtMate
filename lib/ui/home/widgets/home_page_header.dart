import 'package:debtmate/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageHeader extends StatelessWidget {
  final DocumentSnapshot userDoc;
  final String displayName;
  HomePageHeader({super.key, required this.userDoc})
    : displayName = userDoc.get('displayName');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // optional padding
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 126, 244), // background color
        borderRadius: BorderRadius.circular(12), // rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 55,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO Handle notification icon press
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Icon(
                    Icons.price_check,
                    color: Color.fromARGB(255, 0, 126, 244),
                    size: 120,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Hello $displayName!',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 60),
            icon: const Icon(
              Icons.account_circle,
              size: 55,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == 'logout') {
                AuthService().signOut();
                context.go('/login');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
