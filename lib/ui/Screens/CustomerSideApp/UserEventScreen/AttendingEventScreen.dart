import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceScreen.dart/ServiceScreenModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/UpcomingEventScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AttendingEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpcomingEventScreenAppBar(),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'Jamaica Music Festival',
                  fontSize: 20.sp,
                ),
                SizedBox(height: 10.h),
                avenir55RomanText(
                  text: 'About',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10.h),
                avenir55RomanText(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero '
                      'id blandit. In risus neque, commodo quis luctus a, convallis quis sapien. Aliquam vitae pharetra nibh. '
                      'Sed mollis interdum ante sit amet mollis. Vivamus efficitur tincidunt iaculis. Nunc dapibus urna turpis, '
                      'sit amet malesuada massa ornare sit amet. Vivamus egestas, velit eget pretium feugiat, dolor tellus '
                      'tincidunt nisi, sed vestibulum metus nunc quis magna.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10.h),
                avenir55RomanText(
                  text: 'Sed mollis interdum ante sit amet mollis. '
                      'Viva mus efficitur tincidunt iaculis. Nunc dapibus urna tur pis, sit '
                      'amet malesuada massa ornare sit amet. Viva mus egestas, velit eget '
                      'pretium feugiat, dolor tellus tincidunt nisi.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30.h),
                avenir55RomanText(text: 'Event Timeline'),
                SizedBox(height: 5.h),
                Container(
                  width: 388.w,
                  height: 42.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: ShapeDecoration(
                    color: lightGreyColor,
                    shape: StadiumBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avenir55RomanText(
                        text: 'Opening Festival',
                        fontSize: 16.sp,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: greyColor.withOpacity(0.9),
                          ),
                          SizedBox(width: 10.w),
                          avenir55RomanText(
                            text: '09:00 AM - 12:00 PM',
                            color: greyColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    ticketBarCodeBottomSheet(context);
                  },
                  child: CustomGloballyUsedButtonWidget(
                    centerTitle: 'VIEW TICKET',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UpcomingEventScreenAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 300.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 1.sw,
            height: 300.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              image: DecorationImage(
                image: AssetImage(
                  servicesList[0].coverImage,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: whiteColor,
                      child: Icon(
                        Icons.arrow_back,
                        color: blackColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 190.w,
                    height: 30.h,
                    decoration: ShapeDecoration(
                      color: greyColor.withOpacity(0.5),
                      shape: StadiumBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          pinIcon2,
                          color: whiteColor,
                          width: 12.w,
                          height: 12.h,
                        ),
                        SizedBox(width: 5.w),
                        avenir55RomanText(
                          text: 'Downtown, New York',
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -15.h,
            child: Container(
              width: 140.w,
              height: 30.h,
              decoration: ShapeDecoration(
                color: greenColor,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: whiteColor,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: avenir55RomanText(
                  text: '29 August',
                  color: whiteColor,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
