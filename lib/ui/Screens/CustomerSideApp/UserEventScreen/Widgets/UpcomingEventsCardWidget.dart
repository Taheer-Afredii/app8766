import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/UpcomingEventScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpcomingEventsCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avenir55RomanText(text: 'Up Coming Events'),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => UpcomingEventScreen());
              },
              child: IndividualUpcomingEventWidget(),
            );
          },
        ),
      ],
    );
  }
}

class IndividualUpcomingEventWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: 388.w,
        height: 70.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                dummyCoverImage,
                fit: BoxFit.fitHeight,
                width: 70.w,
                height: 70.h,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'Late Night, Club Party',
                  fontSize: 18.sp,
                ),
                Row(
                  children: [
                    Image.asset(
                      pinIcon2,
                      width: 10.w,
                      height: 10.h,
                    ),
                    SizedBox(width: 10.w),
                    avenir55RomanText(
                      text: '19 ST mile Tread, willow brook',
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      appointmentSettingIcon,
                      width: 10.w,
                      height: 10.h,
                    ),
                    SizedBox(width: 10.w),
                    avenir55RomanText(
                      text: '20 Sept, 09:00 PM - 02:00 AM',
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
