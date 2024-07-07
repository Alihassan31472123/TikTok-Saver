
import 'package:tiktokesaverproject/const/app_colors.dart';
import 'package:tiktokesaverproject/widgets/bottom_navigation.dart';
import 'package:tiktokesaverproject/widgets/history/history_widget.dart';
import 'package:tiktokesaverproject/widgets/home/My_drawer.dart';
import 'package:tiktokesaverproject/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;
  final _pages = [
    const HomeWidget(),
    const HistoryWidget(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setPage(int currentPage) {
    setState(() {
      _selectedPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "Tiktoke Saver",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        setPage: _setPage,
      ),
      drawer: MyDrawer(),
      
      );
  }
}
