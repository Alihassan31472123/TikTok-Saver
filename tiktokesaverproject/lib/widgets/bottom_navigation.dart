import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final void Function(int) setPage;

  const BottomNavigation({Key? key, required this.setPage}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.setPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: (index) => _onItemTapped(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}
