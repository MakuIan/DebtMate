import 'package:debtmate/ui/login/widgets/login_form.dart';
import 'package:debtmate/ui/login/widgets/login_header.dart';
import 'package:debtmate/ui/login/widgets/register_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginHeader(),
              SizedBox(height: 16),
              LoginForm(),
              SizedBox(height: 100),
              RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
