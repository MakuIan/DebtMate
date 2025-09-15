import 'package:debtmate/ui/home/widgets/add_friends_box.dart';
import 'package:debtmate/ui/nav/nav_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/home_page_header.dart';

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
            const HomePageHeader(),
            const AddFriendsBox(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
