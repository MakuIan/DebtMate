import 'package:debtmate/ui/widgets/blue_button_style.dart';
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
    super.key,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var logger = Logger();
  void _handleLogin() async {
    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text.trim();

    logger.d('Attempting login with email: $email');

    try {
      // call your AuthService
      final userCredential = await AuthService().login(
        email: email,
        password: password,
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
      ).showSnackBar(SnackBar(content: Text("Email or Password are wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _handleLogin();
      },
      style: AppBlueButtonStyles.elevated,
      child: Text('Login'),
    );
  }
}
