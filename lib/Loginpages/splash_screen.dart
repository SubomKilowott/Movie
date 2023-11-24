// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:movieapp/HomeScreens/navigation.dart';
import 'package:movieapp/Loginpages/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('googleUserId');
    String? userUsername = prefs.getString('googleUsername');
    String? userPhoto = prefs.getString('googlePhoto');

    if (userId != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => MyBottomNavigationBar(
                  Imageurl: userPhoto,
                  userName: userUsername,
                )),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 237, 161, 62),
              Color.fromARGB(255, 6, 101, 178),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/popcorn-movie.gif",
                  height: 300,
                  width: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "A movie App To watch all the movies !!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SpinKitPouringHourGlass(
              color: Colors.black,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
