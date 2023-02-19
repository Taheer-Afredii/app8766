import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/BusinessHomeScreenAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyEventsScreen/CreateNewEventScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => CreateNewEventScreen());
        },
        child: CustomGloballyUsedButtonWidget(
          color: whiteColor,
          borderColor: greenColor,
          centerFontColor: greenColor,
          centerTitle: 'Create New Event',
        ),
      ),
      appBar: BusinessHomeScreenAppBarWidget(
        centerWidget: avenir55RomanText(
          text: 'My Events',
          fontSize: 22.sp,
          color: whiteColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.to(() => AttendingEventScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: MyEventCardWidget(),
                    ),
                  );
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}

class MyEventCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 229.h,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.6),
            spreadRadius: 0.1,
            blurRadius: 5.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
            child: Image.asset(
              dummyCoverImage,
              fit: BoxFit.fill,
              height: 154.h,
              width: 388.w,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 388.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(
                    text: 'Jamaica Music Festival',
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        color: greyColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: 'Attendees:',
                        color: greyColor,
                      ),
                      SizedBox(width: 10.w),
                      avenir55RomanText(
                        text: '273',
                        fontSize: 16.sp,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
