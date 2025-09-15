import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarScaffold extends StatelessWidget {
  final Widget child;
  const NavBarScaffold({super.key, required this.child});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.go('/stats');
    }
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    } else if (location.startsWith('/stats')) {
      return 1;
    }
    return 0; // Default to home
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateIndex(context);
    return Scaffold(
      appBar: AppBar(title: const Text('DebtMate')),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
      ),
    );
  }
}
