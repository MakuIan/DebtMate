import 'package:debtmate/ui/login/widgets/sign_in_google.dart';
import 'package:flutter/material.dart';
import 'package:debtmate/ui/login/widgets/login_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          // Login button
          SizedBox(
            width: double.infinity, // takes full width of parent
            child: LoginButton(
              emailController: emailController,
              passwordController: passwordController,
            ),
          ),
          SizedBox(height: 25),
          // OR divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("OR", style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            ],
          ),
          SizedBox(height: 25),
          //Google Button
          GoogleSignInButton(),

          // Register with Email button
        ],
      ),
    );
  }
}
