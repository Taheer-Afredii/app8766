import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/HomeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../BookingScreen/BookingsScreen.dart';

class MainUserBottomNavigationBar extends StatefulWidget {
  const MainUserBottomNavigationBar({super.key});

  @override
  State<MainUserBottomNavigationBar> createState() =>
      _MainUserBottomNavigationBar();
}

class _MainUserBottomNavigationBar extends State<MainUserBottomNavigationBar> {
  int page = 1;

  List bottomNavigationScreens = [
    BookingScreenTab(),
    HomeScreen(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        color: greenColor,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          ImageIcon(
            AssetImage(bottomNavClockImage),
            color: whiteColor,
          ),
          ImageIcon(
            AssetImage(bottomNavHomeImage),
            color: whiteColor,
          ),
          ImageIcon(
            AssetImage(bottomNavAnnouncementImage),
            color: whiteColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
      body: bottomNavigationScreens[page],
    );
  }
}
