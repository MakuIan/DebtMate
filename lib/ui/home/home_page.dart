import 'package:debtmate/ui/main/nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(child: Center(child: Text('Home Page')));
  }
}
