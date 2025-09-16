import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:debtmate/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var logger = Logger();
  void _handleLogin() async {
    final _email = widget.emailController.text.trim();
    final _password = widget.passwordController.text.trim();

    logger.d('Attempting login with email: $_email');

    try {
      // call your AuthService
      final userCredential = await AuthService().login(
        email: _email,
        password: _password,
      );
      final user = userCredential.user;
      if (user != null) {
        logger.d("Login successful ✅");
        logger.d("User ID: ${user.uid}");

        if (user.emailVerified) {
          logger.d("Email is verified ✅");
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("login successful")));
          context.go('/home');
        } else {
          logger.d("Email is NOT verified ❌");
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("email not yet verified")));
          await user.sendEmailVerification();
        }
      }

      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _handleLogin();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Color.fromARGB(255, 0, 126, 244),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
      ),
      child: Text('Login'),
    );
  }
}
