import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearlySubscriptionCardWidget extends StatelessWidget {
  final String monthlyAmount;
  final String yearlyAmount;
  final String noServicesGranted;

  YearlySubscriptionCardWidget({
    required this.monthlyAmount,
    required this.noServicesGranted,
    required this.yearlyAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 388.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(yearlySubscriptionImage),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              avenir55RomanText(
                text: "Annually",
                fontSize: 23.sp,
                color: whiteColor,
              ),
              avenir55RomanText(
                text: '\$$yearlyAmount',
                fontSize: 23,
                color: whiteColor,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              avenir55RomanText(
                text: "\$$monthlyAmount",
                fontSize: 17,
                color: whiteColor,
              ),
              avenir55RomanText(
                color: lightGreyColor,
                text: " / Month",
                fontSize: 17,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          avenir55RomanText(
            color: whiteColor,
            text: "$noServicesGranted Services/Products",
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
