import 'package:debtmate/ui/register/widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'package:debtmate/ui/login/widgets/login_header.dart';
import 'package:debtmate/ui/register/widgets/return_to_login.dart';
import 'package:debtmate/ui/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RegisterHeader(),
              SizedBox(height: 16),
              RegisterForm(),

              // RegisterButton(),
              SizedBox(height: 16),
              ReturnToLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
