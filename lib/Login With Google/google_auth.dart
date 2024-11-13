import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  // Initialize FirebaseAuth and GoogleSignIn instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method for Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
         // Attempt to sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google sign-in aborted by user.");
        return null; // User canceled the sign-in
      }

      // Get authentication details from the Google account
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      print("User signed in successfully: ${user?.displayName}");
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      print("FirebaseAuthException: ${e.message}");
      return null;
    } catch (e) {
      // Handle any other errors
      print("Error during Google sign-in: $e");
      return null;
    }
  }

  // Method for signing out from Google and Firebase
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
}
