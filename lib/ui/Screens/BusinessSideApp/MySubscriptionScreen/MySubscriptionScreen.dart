import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MySubscriptionScreen/Widgets/YearlySubscriptionCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySubscriptionScreen extends StatefulWidget {
  @override
  State<MySubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  bool autoRenewal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'Platform Subscription'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              premiumIcon,
              width: 150.w,
              height: 150.h,
            ),
            SizedBox(height: 50.h),
            YearlySubscriptionCardWidget(
              monthlyAmount: '142',
              yearlyAmount: '1,705',
              noServicesGranted: '15',
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'Subscription',
                  fontSize: 18.sp,
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 388.w,
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color: lightGreyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avenir55RomanText(
                        text: 'Next renewal',
                        fontSize: 16.sp,
                      ),
                      avenir55RomanText(
                        text: '01 Aug, 2023',
                        fontSize: 16.sp,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  shape: CircleBorder(),
                  fillColor: MaterialStateProperty.all(greenColor),
                  value: autoRenewal,
                  onChanged: (value) {
                    setState(
                      () {
                        autoRenewal = value!;
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 320.w,
                  child: avenir55RomanText(
                    text: 'Auto renewal (Subscription will be auto '
                        'renewed base on your package plan)',
                    fontSize: 18.sp,
                    color: blackColor.withOpacity(0.6),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
