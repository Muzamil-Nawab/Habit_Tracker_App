import 'package:flutter/material.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/home_screen.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/profile_screen.dart';
import 'package:habits_tracker_app/bottom_navigation_bar/statistics_screen.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  /// thsi is for showing current index of tabs
  int _currentIndex = 0;

  ///     here is bottom tab screen    /////
  final List<Widget> _screens = [
    HomeScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1F2442),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined, color: Colors.white),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
