import 'package:flutter/material.dart';
import './navigation/home.dart';
import './navigation/exercises.dart';
import './navigation/planning.dart';
import './navigation/chat.dart';
import './navigation/settings.dart';

class Afterlogin extends StatefulWidget {
  final int userId;

  Afterlogin({required this.userId});

  @override
  _AfterloginState createState() => _AfterloginState();
}

class _AfterloginState extends State<Afterlogin> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
        Home(userId: widget.userId),
        Exercises(),
        Planning(userId: widget.userId),
        Chat(userId: widget.userId),
        Settings(userId: widget.userId),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c1c1e),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: _screens[_currentIndex],
          ),
          Expanded(
            flex: 1,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFFA4DC5D), // Change here
              unselectedItemColor: Colors.black,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              iconSize: 24.0,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.fitness_center,
                  ),
                  label: 'Exercise',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_add_rounded),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
