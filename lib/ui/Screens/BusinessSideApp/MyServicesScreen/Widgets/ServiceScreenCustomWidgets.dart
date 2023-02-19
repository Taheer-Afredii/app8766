import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/BoostServiceScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/MyServicesScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/MyServicesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoostPostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BoostServiceScreen());
      },
      child: Container(
        width: 388.w,
        height: 62.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: goldColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              premiumIcon,
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                avenir55RomanText(
                  text: 'BOOST SERVICES',
                  fontSize: 18.sp,
                  color: goldColor,
                ),
                avenir55RomanText(
                  text: 'Grow up your business & reach out more customers',
                  color: blackColor.withOpacity(0.6),
                  fontSize: 12.sp,
                )
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: goldColor,
              size: 35.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class MyServicesCardWidget extends StatelessWidget {
  final MyServicesViewModel model;

  final ServiceModel data;
  MyServicesCardWidget({required this.data, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                width: 50.w,
                height: 50.h,
                chairIcon,
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  avenir55RomanText(
                      text: data.serviceName ?? "loading", fontSize: 16.sp),
                  SizedBox(height: 7.h),
                  avenir55RomanText(
                    text: data.serviceTime ?? "loading",
                  ),
                  SizedBox(height: 7.h),
                  avenir55RomanText(
                    text: 'Price: \$${data.servicePrice ?? "loading"}',
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    //remove services button
                    await model.removeService(docid: data.docid!);
                  },
                  child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: whiteColor,
                    child: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: redColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // Apply Edit function here
                    Get.to(() => EditService(
                          docid: data.docid!,
                        ));
                  },
                  child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: whiteColor,
                    child: Icon(
                      Icons.edit,
                      size: 16.sp,
                      color: greenColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
