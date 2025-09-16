import 'package:debtmate/services/auth_service.dart';
import 'package:debtmate/ui/reset_password/widget/reset_password_header.dart';
import 'package:debtmate/ui/widgets/blue_button_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void _resetPassword() async {
    final email = emailController.text.trim();
    await AuthService().resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 60),
              const ResetPasswordHeader(),
              const SizedBox(height: 60),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: AppBlueButtonStyles.elevated,
                  onPressed: () {
                    _resetPassword();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset email sent!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    context.go('/login');
                  },
                  child: const Text('Reset Password'),
                ),
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: 100,
                child: TextButton(
                  style: AppBlueButtonStyles.elevated,
                  onPressed: () => context.go('/login'),
                  child: const Text('Return'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
