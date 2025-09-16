import 'package:debtmate/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final logger = Logger();

  void _resetPassword() async {
    final email = emailController.text.trim();

    await AuthService().resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _resetPassword();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Password reset email sent!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                context.go('/login');
              },
              child: Text('Reset Password'),
            ),
            TextButton(
              onPressed: () => {context.go('/login')},
              child: Text('Return'),
            ),
          ],
        ),
      ),
    );
  }
}
