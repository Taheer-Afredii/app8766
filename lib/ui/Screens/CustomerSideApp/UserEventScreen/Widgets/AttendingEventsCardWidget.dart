import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/AttendingEventScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/ListOfGoingForEventsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AttendingEventsCardWigdet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            avenir55RomanText(text: 'Attending Event'),
            GestureDetector(
              onTap: () {
                //TODO: Add function here
                Get.to(() => ListOfGoingForEventsScreen());
              },
              child: avenir55RomanText(
                text: 'View all',
                color: greenColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 1.sw,
          height: 150.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => AttendingEventScreen());
                },
                child: IndividualEventListCardWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class IndividualEventListCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        width: 225.w,
        height: 130.h,
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
            Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: Image.asset(
                    dummyCoverImage,
                    fit: BoxFit.fill,
                    height: 88.h,
                    width: 225.w,
                  ),
                ),
                Positioned(
                  bottom: -10.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5.r),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              avenir55RomanText(
                                text: '29',
                                color: greenColor,
                                fontSize: 12.sp,
                              ),
                              avenir55RomanText(
                                text: 'August',
                                fontSize: 8.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 225.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avenir55RomanText(
                      text: 'Jamaica Music Festival',
                      fontSize: 12.sp,
                    ),
                    avenir55RomanText(
                      text: '19 ST mile Tread, willow brook',
                      color: greyColor,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
