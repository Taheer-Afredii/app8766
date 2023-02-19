import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/BusinessBookingsScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/HomeScreen/BusinessHomeScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyEventsScreen/MyEventsScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainBusinessBottomNavigationBar extends StatefulWidget {
  const MainBusinessBottomNavigationBar({super.key});

  @override
  State<MainBusinessBottomNavigationBar> createState() =>
      _MainBusinessBottomNavigationBar();
}

class _MainBusinessBottomNavigationBar
    extends State<MainBusinessBottomNavigationBar> {
  int page = 1;

  List bottomNavigationScreens = [
    BusinessBookingScreenTab(),
    BusinessHomeScreen(),
    MyEventsScreen(),
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
