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

            final route = (userCredential.user != null) ? '/home' : '/login';
            if (context.mounted) {
              context.go(route);
            }
          } catch (e) {
            // Handle error

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error signing in with Google: $e')),
              );
            }
          }
        },
        icon: Image.asset(
          'assets/icons/signin-assets/iOS/png@1x/neutral/ios_neutral_rd_ctn@1x.png',
        ),
      ),
    );
  }
}
