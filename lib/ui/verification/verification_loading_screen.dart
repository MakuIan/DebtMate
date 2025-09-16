import 'package:debtmate/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class VerificationLoadingScreen extends StatefulWidget {
  final String email;

  const VerificationLoadingScreen({super.key, required this.email});

  @override
  _VerificationLoadingScreenState createState() =>
      _VerificationLoadingScreenState();
}

class _VerificationLoadingScreenState extends State<VerificationLoadingScreen> {
  bool isVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (_) => checkEmailVerified());
  }

  Future<void> checkEmailVerified() async {
    // Replace with your API call or Firebase check
    bool verified = await AuthService().isEmailVerified();

    if (verified) {
      timer?.cancel();
      // Navigate to Home page
      if (!mounted) return;
      context.go('/home');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Waiting for email verification...'),
          ],
        ),
      ),
    );
  }
}
