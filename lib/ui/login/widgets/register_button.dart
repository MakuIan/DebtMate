import 'package:flutter/material.dart';
import 'package:debtmate/services/auth_service.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: call AuthService register logic here
      },
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 126, 244),
      ),
      child: const Text("Register with Email", style: TextStyle(fontSize: 16)),
    );
  }
}
