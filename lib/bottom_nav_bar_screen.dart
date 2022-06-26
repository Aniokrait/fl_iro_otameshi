import 'package:flutter/material.dart';

import 'main.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNaviBarState();

}

class _BottomNaviBarState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  static final List<TabPage> _tabPages = [
    const TabPage(
      title: 'Home',
      icon: Icon(Icons.home),
    ),
    const TabPage(
      title: 'Food',
      icon: Icon(Icons.restaurant),
    ),
    const TabPage(
      title: 'Book',
      icon: Icon(Icons.book),
    ),
    const TabPage(
      title: 'Music',
      icon: Icon(Icons.music_note),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bottom navibar"),
      ),
      body: _tabPages[_selectedIndex],
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget get bottomNavigationBar => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                //color: Colors.grey,
              ),
              label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant,
              ),
              label: 'FOOD'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
              ),
              label: 'BOOK'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.music_note,
              ),
              label: 'MUSIC'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class TabPage extends StatelessWidget {
  final String title;
  final Icon icon;
  const TabPage({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(title),
        ),
      ],
    );
  }
}
