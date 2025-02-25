import 'package:dd_shop/dashboard/Dashboard.dart';
import 'package:dd_shop/orders/order_screen.dart';
import 'package:dd_shop/shop_signup/shop_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [Dashboard(), Orders(), ShopScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.dashboard,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.local_hospital,
              //color: Colors.red,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    _currentIndex = index;
    setState(() {
      if (_currentIndex == 0)
        index = _currentIndex;
      else if (_currentIndex == 1)
        index = _currentIndex;
      else if (_currentIndex == 2) index = _currentIndex;
    });
  }
}
