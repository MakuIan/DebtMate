import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnToLogin extends StatelessWidget {
  const ReturnToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go('/login');
      },
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 126, 244),
      ),
      child: const Text(
        'Already have an Account? Login',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
