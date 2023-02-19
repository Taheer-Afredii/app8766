import 'package:app_876/core/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GlobalBackButtonWidget extends StatelessWidget {
  final Color? backButtonColor;
  final double? backButtonSize;

  GlobalBackButtonWidget({
    this.backButtonColor,
    this.backButtonSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back,
        size: backButtonSize ?? 30.sp,
        color: backButtonColor ?? whiteColor,
      ),
    );
  }
}
