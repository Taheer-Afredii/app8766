import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';

class TextFieldwithTitleWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final double? width;
  final double? height;

  TextFieldwithTitleWidget({
    required this.controller,
    required this.hintText,
    required this.title,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avenir55RomanText(
          text: title,
          fontSize: 16.sp,
          color: blackColor.withOpacity(0.5),
        ),
        SizedBox(height: 5.h),
        Container(
          width: width ?? 388.w,
          height: height ?? 60.h,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(
            color: lightGreyColor,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: avenir55RomanStyle(
                fontSize: 16.sp,
                color: blackColor.withOpacity(0.5),
              ),
            ),
          ),
        )
      ],
    );
  }
}
