import 'package:debtmate/ui/nav/nav_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/home_page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(
      backgroundColor: Color.fromARGB(255, 0, 126, 244),
      child: SafeArea(
        child: Column(
          children: [
            HomePageHeader(),
            //Friends Box
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Main Content Area')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
