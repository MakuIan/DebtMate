import 'package:flutter/material.dart';
import 'package:debtmate/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go('/register');
      },
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 126, 244),
      ),
      child: const Text(
        "Don't have an account? Sign up",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
