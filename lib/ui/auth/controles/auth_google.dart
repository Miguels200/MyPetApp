import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AuthUser {
  static Future<User?> loginGoogle() async {
    try {
      if (kIsWeb) {
        // Autenticación web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Autenticación móvil
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          // El usuario canceló el inicio de sesión
          return null;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print('Error en loginGoogle: $e');
      return null;
    }
  }
}

