import 'dart:async';
import 'dart:developer';

import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BottomNavScreen/MainBusinessBottomNavigationBar.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/customer_authscreens_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/BottomNavScreens/MainUserBottomNavigationBar.dart';
import 'package:app_876/ui/ServiceSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    sharedPref();
  }

  sharedPref() async {
    Provider.of<CustomerAuthScreenViewModel>(context, listen: false)
        .getLocation(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 2), () async {
      var customeremail = prefs.getString('cemail');
      var businessemail = prefs.getString("bemail");
      if (customeremail != null) {
        await Get.offAll(() => MainUserBottomNavigationBar());
      } else if (businessemail != null) {
        await Get.offAll(() => MainBusinessBottomNavigationBar());
      } else {
        await Get.offAll(() => ServiceSelectionScreen());
      }
      log("customeremail in splash: $customeremail");
      log("businessUidemail in splash: $businessemail");
    });
  }

  @override
  void dispose() {
    // Provider.of<CustomerAuthScreenViewModel>(context, listen: false)
    //     .getLocation(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Lottie.asset(splashScreenAnimation, fit: BoxFit.fill),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  appIconBlack,
                  scale: 2,
                ),
                SizedBox(height: 5.h),
                avenir55RomanText(
                  text: 'App876',
                  color: whiteColor,
                  fontSize: 18.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
