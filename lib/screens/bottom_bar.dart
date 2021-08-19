import 'package:shop_app/consts/my_icons.dart';

import 'search.dart';
import 'user_info.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'feeds.dart';
import 'home.dart';

class BottomBarScreen extends StatefulWidget {

  static final routeName="/BottomBarScreen";

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  /* List _pages = [
    HomeScreen(),
    FeedsScreen(),
    SearchScreen(),
    CartScreen(),
    UserInfoScreen(),
  ];*/

  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {"page": HomeScreen(), "title": "Home Screen"},
      {"page": FeedsScreen(), "title": "Feeds Screen"},
      {"page": SearchScreen(), "title": "Search Screen"},
      {"page": CartScreen(), "title": "Cart Screen"},
      {"page": UserInfoScreen(), "title": "User Info Screen"},
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 3,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          //height: kBottomNavigationBarHeight*0.8,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.4),
            ),
          ),
          child: BottomNavigationBar(
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            //selectedLabelStyle: TextStyle(fontSize: 16),
            items: [
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.home),
                tooltip: "Home",
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.rss),
                tooltip: "Feeds",
                label: "Feeds",
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                tooltip: "Search",
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.bag),
                tooltip: "Cart",
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.user),
                tooltip: "User",
                label: "User",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        tooltip: "Search",
        elevation: 5,
        child: Icon(MyAppIcons.search),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }
}
