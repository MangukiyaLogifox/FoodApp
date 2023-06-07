import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/add_cart_screen.dart';
import 'package:food_app/Screen/menu_screen.dart';
import 'package:sizer/sizer.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _curruntindex = 0;
  static const List _pages = [
    MenuScreen(),
    MenuScreen(),
    AddCartScreen(),
    MenuScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_curruntindex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 3.h,
          backgroundColor: AppColor.btn,
          selectedItemColor: AppColor.darkIndigo,
          currentIndex: _curruntindex,
          onTap: (value) {
            setState(() {
              _curruntindex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: ''),
          ]),
    );
  }
}
