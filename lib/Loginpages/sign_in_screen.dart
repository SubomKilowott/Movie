// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movieapp/HomeScreens/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  Future<User?> _handleSignIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // User canceled the sign-in, return null.
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('googleUserId', googleSignInAccount.id);
      prefs.setString('googleUsername', googleSignInAccount.displayName ?? '');
      prefs.setString('googlePhoto', googleSignInAccount.photoUrl ?? '');

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print("Error during Google sign-in: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Welcome to",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text(
              "Cinema",
              style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              "Get Access to all the movies you always wanted to see!!",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            SignInButton(
              Buttons.google,
              onPressed: () async {
                final user = await _handleSignIn();

                // Successfully signed in with Google.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBottomNavigationBar(
                      userName: user?.displayName,
                      Imageurl: user?.photoURL,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
