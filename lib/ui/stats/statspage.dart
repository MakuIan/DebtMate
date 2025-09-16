import 'package:debtmate/ui/nav/nav_bar.dart';
import 'package:flutter/material.dart';

class Statspage extends StatelessWidget {
  const Statspage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(
      backgroundColor: Color.fromARGB(255, 0, 126, 244),
      child: Center(child: Text('Stats Page')),
    );
  }
}
