import 'package:debtmate/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var logger = Logger();

  // Sign in with email and password
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Send Verification Email
    logger.d('Verification email sent to $email');
    await userCredential.user?.sendEmailVerification();

    String uid = userCredential.user!.uid;
    logger.d('New user created with UID:');
    logger.d('New user created with UID: $uid');

    await createUserWithFriendCodeInFirestore(uid, email);

    return userCredential;
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    // Access the signed-in user's information
    User? user = userCredential.user;

    if (user != null) {
      String uid = user.uid; // Firebase Auth UID
      String? email = user.email;

      if (email != null) await createUserWithFriendCodeInFirestore(uid, email);
    } // Google account email

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Check if email is verified
  Future<bool> isEmailVerified() async {
    User? user = getCurrentUser();
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      logger.d("Password reset email sent!");
    } on FirebaseAuthException catch (e) {
      logger.d("Error: ${e.message}");
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
