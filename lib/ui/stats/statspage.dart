import 'package:debtmate/ui/nav/nav_bar.dart';
import 'package:flutter/material.dart';

class Statspage extends StatelessWidget {
  const Statspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(child: Center(child: Text('Stats Page')));
  }
}
