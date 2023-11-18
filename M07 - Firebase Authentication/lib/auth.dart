import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    // membuat (menambahkan) user baru dengan email dan password yang diberikan pada Firebase Authentication
    // jika pendaftaran berhasil, maka Firebase akan mengembalikan data berupa data User Unique ID
    UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = authResult.user;
    return user?.uid;
  }

  Future<String?> login(String email, String password) async {
    // melakukan pengecekan berdasarkan email dan password yang diberikan pada Firebase Authentication
    // jika otentikasi berhasil, maka Firebase akan mengembalikan data berupa data User Unique ID
    try {
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      return user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> googleAuth() async {
    // CHATGPT murni
    try {
      // Initialize Firebase Auth and Google Sign-In
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      // Create a credential from the GoogleSignInAccount
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in with the Google credential
      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      
      return user?.uid;
    } catch (error) {
      print('Google sign-in error: $error');
      return null;
    }
  }

  Future<String?> facebookAuth() async {
    // CHATGPT murni
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);

        // Sign in with the Facebook credential
        final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
        final User? user = authResult.user;
        
        return user?.uid;
      } else {
        throw 'Facebook sign-in error!';
      }
      
    } catch (error) {
      print('Facebook sign-in error: $error');
      return null;
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print("Password reset email sent. Check your email inbox.");
      return "Sending";
    } catch (error) {
      print("Error sending password reset email: $error");
      return null;
    }
  }

  Future<User?> getUser() async {
    // mengambil data user yang sedang login pada Firebase dan mengembalikan data berupa data User
    // jika tidak ada user yang sedang login, maka Firebase akan mengembalikan data null
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    print("Signed Out");
  }
}