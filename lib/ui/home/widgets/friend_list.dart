import 'package:debtmate/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:debtmate/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: StreamBuilder<List<Friend>>(
          stream: UserService().getFriendsStream(
            _auth.currentUser!.uid,
          ), // Your stream
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No friends found'));
            }

            // Use the data from the snapshot
            List<Friend> friendsList = snapshot.data!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: friendsList.length, // <-- set itemCount
              itemBuilder: (context, index) {
                final friend = friendsList[index];

                //TODO Friend Widget
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 48,
                      color: friend.isManual ? Colors.blue : Colors.green,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      friend.displayName,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
