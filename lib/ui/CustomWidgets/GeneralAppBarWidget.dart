import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/colors.dart';

class GeneralAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  VoidCallback? ontap;
  final String title;
  final Widget? trailing;

  GeneralAppBarWidget({
    required this.title,
    this.trailing,
    this.ontap,
  });

  @override
  Size get preferredSize => Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.h),
      child: Container(
        height: 150.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ontap ??
                          () {
                            Get.back();
                          },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.sp,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    avenir55RomanText(
                      text: title,
                      fontSize: 22.sp,
                      color: whiteColor,
                    ),
                  ],
                ),
                trailing ?? SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
