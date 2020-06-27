import 'package:flutter/material.dart';
import 'package:appexample/view/explore_page/page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
//  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    ExplorePage(),
    ExplorePage(),
    ExplorePage(),
//    SavedTripPage(),
//    CreateTrip(),
//    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Explore'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xfff05042),
        onTap: _onItemTapped,
        unselectedItemColor: Color(0xff3a3a3a),
        showUnselectedLabels: true,
      ),
    );
  }
}