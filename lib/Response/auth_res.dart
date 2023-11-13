// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/Components/error_message.dart';
import 'package:shopping_app/Screens/home.dart';
import 'package:shopping_app/Screens/Auth/login.dart';

class AuthResponse {
  //Login with Email and password
  userLogin(String useremail, String userpassword, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: userpassword)
          .then((value) => {
                ErrorMessage.toastMessage("Login Sucessfully"),
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()))
              });
    } catch (e) {
      ErrorMessage.toastMessage(e.toString());
    }
  }

  //Login with google
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return ErrorMessage.toastMessage(e.toString());
    }
  }

  //Login with Facebook
  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile', 'user_birthday']);

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // var getData = FacebookAuth.instance.getUserData();
      ErrorMessage.toastMessage("Facebook");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      return ErrorMessage.toastMessage(e.toString());
    }
  }

  //Sign in with Email and Password
  static userSignup(BuildContext context, String email, String password,
      String username, String phone) async {
    String id = DateTime.now().millisecond.toString();
    final fireStore = FirebaseFirestore.instance.collection('users');
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                fireStore.doc(id).set({
                  'id': id,
                  'username': username,
                  'userphone': phone,
                  'useremail': email,
                  'userpassword': password,
                }).then((value) async {
                  ErrorMessage.toastMessage("Data Uploaded");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                  ErrorMessage.toastMessage("Signup Sucessfully");
                }).catchError((error) {
                  ErrorMessage.toastMessage("Error adding data: $error");
                })
              });
    } catch (e) {
      ErrorMessage.toastMessage(e.toString());
    }
  }

  static logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => {
                ErrorMessage.toastMessage("Logout Sucessfully"),
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()))
              })
          .onError((error, stackTrace) =>
              {ErrorMessage.toastMessage(error.toString())});
    } catch (e) {
      ErrorMessage.toastMessage(e.toString());
    }
  }
}
