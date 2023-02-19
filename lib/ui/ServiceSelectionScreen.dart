import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Screens/BusinessSideApp/AuthScreens/BusinessSignInScreen/BusinessSignInScreen.dart';
import 'Screens/CustomerSideApp/AuthScreens/CustomerSignINScreen/CustomerSignInScreen.dart';

class ServiceSelectionScreen extends StatelessWidget {
  const ServiceSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(serviceSelectionBackgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        color: Colors.black38,
        height: 1.sh,
        width: 1.sw,
        child: SafeArea(
          child: Column(
            children: [
              Spacer(),
              Column(
                children: [
                  avenir55RomanText(
                    text: "Get Service Providers",
                    color: whiteColor,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 18.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CustomerSignInScreen());
                    },
                    child: ServiceProviderScreenButtonWidget(
                        centerText: 'CUSTOMER'),
                  ),
                ],
              ),
              Spacer(),
              Spacer(),
              Column(
                children: [
                  avenir55RomanText(
                    text: "Business owner",
                    color: whiteColor,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 18.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => BusinessSignInScreen());
                    },
                    child: ServiceProviderScreenButtonWidget(
                        centerText: 'SERVICE PROVIDERS'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ServiceProviderScreenButtonWidget extends StatelessWidget {
  final String centerText;

  ServiceProviderScreenButtonWidget({required this.centerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 62.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.r),
        border: Border.all(color: whiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.arrow_forward,
            color: Colors.transparent,
          ),
          avenir55RomanText(
            text: centerText,
            fontSize: 20.sp,
            color: whiteColor,
          ),
          Icon(
            Icons.arrow_forward,
            color: whiteColor,
          ),
        ],
      ),
    );
  }
}
