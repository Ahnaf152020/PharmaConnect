import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/pages/HomePage.dart';
import 'package:pharmaconnectbyturjo/pages/Update_Profile.dart';
import 'package:pharmaconnectbyturjo/pages/cart.dart';
import 'package:pharmaconnectbyturjo/widget.dart';

/// This is the stateful widget that the main application instantiates.
class MyBottomBar extends StatefulWidget {
  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

/// This is the private State class that goes with MyBottomBar.
class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    cart(),
    Mywidget(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_sharp),

            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),

            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(),
        // selectedItemColor: AppColors.baseDarkPinkColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
