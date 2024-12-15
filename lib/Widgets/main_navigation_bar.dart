import 'package:flutter/material.dart';
import '../View/HomePage.dart';
import '../View/MyPledgedGiftsPage.dart';
import '../View/ProfilePage.dart';



class MainNavigationBar extends StatefulWidget {
  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    MyPledgedGiftsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'My Gifts',
          ),
        ],
      ),
    );
  }
}
