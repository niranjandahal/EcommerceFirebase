import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:r12shopprovider/cache/categorycache.dart';
import 'package:r12shopprovider/screens/carts.dart';
import 'package:r12shopprovider/screens/profile.dart';
import 'package:r12shopprovider/section/homcatbottomsection.dart';
import 'package:r12shopprovider/section/hometopsection.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePageindex(),
    Carts(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.cartShopping,
              size: 20,
            ),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageindex extends StatefulWidget {
  const HomePageindex({super.key});

  @override
  State<HomePageindex> createState() => _HomePageindexState();
}

class _HomePageindexState extends State<HomePageindex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Today's Deals",
                    style: TextStyle(
                      color: Colors.orange[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HomeTopSection(),
                const SizedBox(
                  height: 10,
                ),
                categorysection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
