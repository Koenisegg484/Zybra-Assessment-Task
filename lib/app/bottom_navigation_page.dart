import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/preferences_screen.dart';

import '../config/themes/size_config.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final List<Widget> _pages = [
    TodoHomeScreen(),
    Container(),
    PreferencesScreen()
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _navItems = [
    ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
          padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade800
            ),
            child: Icon(Icons.home_rounded, color: Colors.white,)
        )
    ),
    ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
          padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade800
            ),
            child: Icon(Icons.add_rounded, color: Colors.white,)
        )
    ),
    ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade800
          ),
            child: Icon(Icons.settings_rounded, color: Colors.white,)
        )
    )
  ];

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: Color(0xfef5bbfd),
        index: _currentIndex,
        items: _navItems,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage( index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut, );
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
