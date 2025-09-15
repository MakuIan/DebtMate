import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarScaffold extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const NavBarScaffold({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

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
      backgroundColor: backgroundColor,
      body: child,
      bottomNavigationBar: Container(
        color: Colors.white, // keeps background clean (optional)
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              backgroundColor: backgroundColor,
              currentIndex: selectedIndex,
              onTap: (index) => _onItemTapped(context, index),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.white),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart, color: Colors.white),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
