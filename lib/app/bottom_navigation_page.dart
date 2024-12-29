import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/create_task_screen.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/preferences_screen.dart';
import '../config/themes/constants.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final List<Widget> _pages = [
    const TodoHomeScreen(),
    CreateTaskScreen(),
    PreferencesScreen()
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _navItems = [
    ClipRRect(
        borderRadius: BR50,
        child: Container(
          padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade800
            ),
            child: whiteSimpleIcon(icondata: Icons.home_rounded)
        )
    ),
    ClipRRect(
        borderRadius: BR50,
        child: Container(
          padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade800
            ),
            child: whiteSimpleIcon(icondata: Icons.add_rounded)
        )
    ),
    ClipRRect(
      borderRadius: BR50,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade800
          ),
            child: whiteSimpleIcon(icondata: Icons.settings_rounded)
        )
    )
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: lightPink,
        index: _currentIndex,
        items: _navItems,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage( index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut, );
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
    );
  }
}
