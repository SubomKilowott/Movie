// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movieapp/HomeScreens/Tab_screen.dart';
import 'package:movieapp/HomeScreens/Watchlist_screen.dart';
import 'package:movieapp/HomeScreens/home_screen_second.dart';
import 'package:movieapp/Loginpages/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    this.userName,
    this.Imageurl,
  });

  final String? userName;
  final String? Imageurl;

  @override
  // ignore: library_private_types_in_public_api
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future _signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Secondpage(),
    const Screen2(),
    const Tabs(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          ' Welcome!! ${widget.userName ?? "Guest"}',
          style: const TextStyle(fontSize: 18),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.Imageurl ?? ''),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _signOut();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignIn()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color.fromARGB(255, 47, 47, 47),
        currentIndex: _currentIndex,
        selectedFontSize: 15,
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 20,
            ),
            label: 'Dashboard',
            backgroundColor: Color.fromARGB(255, 131, 131, 131),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.visibility,
              size: 20,
            ),
            label: 'WatchList',
            backgroundColor: Color.fromARGB(255, 77, 77, 77),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.graphic_eq,
              size: 20,
            ),
            label: 'Graphs',
            backgroundColor: Color.fromARGB(255, 40, 39, 39),
          ),
        ],
      ),
    );
  }
}
