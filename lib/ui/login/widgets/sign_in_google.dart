import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        onPressed: () {
          // TODO: handle Google sign-in
        },
        icon: Image.asset(
          'assets/icons/signin-assets/iOS/png@1x/light/ios_light_sq_SU@1x.png',
        ),
      ),
    );
  }
}
