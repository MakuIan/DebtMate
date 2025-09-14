import 'package:debtmate/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        onPressed: () async {
          try {
            UserCredential userCredential = await AuthService()
                .signInWithGoogle();

            if (!mounted) return;
            if (userCredential.user != null) {
              context.go('/home');
            } else {
              context.go('/login');
            }
          } catch (e) {
            // Handle error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error signing in with Google: $e')),
            );
          }
        },
        icon: Image.asset(
          'assets/icons/signin-assets/iOS/png@1x/light/ios_light_sq_SU@1x.png',
        ),
      ),
    );
  }
}
