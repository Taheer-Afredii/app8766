import 'dart:developer';

import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceProviderDetailsScreen/ServiceReportScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ServiceProviderDetailsScreen extends StatelessWidget {
  SelectedServiceModel data;
  ServiceProviderDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    log("services${data.Services!.length}");

    log("docid${data.docId}");
    return Scaffold(
      appBar: GeneralAppBarWidget(
        title: '"Service type here" Details',
        trailing: GestureDetector(
          onTap: () {
            //TODO: Add report function and route here
            Get.to(() => ServiceProviderReportScreen(
                  data: data,
                ));
          },
          child: Image.asset(
            width: 25.w,
            height: 25.h,
            warningORreportIcon,
            color: whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Container(
              width: 388.w,
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: lightGreyColor,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(
                      data.businessProfileImage.toString(),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      avenir55RomanText(
                        text: data.businessName.toString(),
                        fontSize: 18.sp,
                      ),
                      avenir55RomanText(
                        text: 'Cuts for pros',
                        fontSize: 12.sp,
                      ),
                      avenir55RomanText(
                        text: '207 Halsey Street, Brooklyn, New York, 90001',
                        fontSize: 12.sp,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ServiceAppointmentDetailsCardWidget(
              title: 'Appointment Date',
              subtitleWidget: Row(
                children: [
                  Image.asset(
                    bottomNavClockImage,
                    color: blackColor.withOpacity(0.6),
                    width: 15.w,
                    height: 15.h,
                  ),
                  SizedBox(width: 10.w),
                  avenir55RomanText(
                    text:
                        DateFormat('dd MMMM, yyyy').format(data.date!.toDate()),
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            ServiceAppointmentDetailsCardWidget(
              title: 'Services',
              subtitleWidget: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: data.Services!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Image.asset(
                        width: 15.w,
                        height: 15.h,
                        chairIcon,
                        color: blackColor.withOpacity(0.6),
                      ),
                      SizedBox(width: 10.w),
                      avenir55RomanText(
                        text: data.Services![index]["serviceName"].toString(),
                        maxLines: 2,
                        fontSize: 16.sp,
                      ),
                    ],
                  );
                },
              ),
            ),
            ServiceAppointmentDetailsCardWidget(
              title: 'Location',
              subtitleWidget: Row(
                children: [
                  Image.asset(
                    pinIcon2,
                    color: blackColor.withOpacity(0.6),
                    width: 15.w,
                    height: 15.h,
                  ),
                  SizedBox(width: 10.w),
                  avenir55RomanText(
                    text: '207 Halsey Street, Brooklyn, New York, 90001',
                    fontSize: 12.sp,
                  ),
                ],
              ),
              trailingIcon: GestureDetector(
                onTap: () {
                  mapLaunch(data.businessLatitude.toString(),
                      data.businessLongitude.toString());
                },
                child: Column(
                  children: [
                    Image.asset(
                      width: 30.w,
                      height: 30.h,
                      sendMessageFlyIcon,
                    ),
                    avenir55RomanText(text: 'Direction'),
                  ],
                ),
              ),
            ),
            ServiceAppointmentDetailsCardWidget(
              title: 'Price',
              subtitleWidget: Row(
                children: [
                  Image.asset(
                    dollarIcon,
                    color: blackColor.withOpacity(0.6),
                    width: 15.w,
                    height: 15.h,
                  ),
                  SizedBox(width: 10.w),
                  avenir55RomanText(
                    text:
                        '\$ ${data.totalAmount} ${data.mobilePay! ? ("(Pay via mobile)") : ("(Pay on Site)")}',
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CustomGloballyUsedButtonWidget(
                color: blackColor,
                centerFontColor: whiteColor,
                borderRadius: 50.r,
                centerTitle: 'DONE',
              ),
            ),
            SizedBox(height: 20.h),
            avenir55RomanText(
              text: 'Please make sure to visit the appointment date, to '
                  'sustain your show up percentage and avoid abuse or '
                  'other miss behavior on the platform',
            )
          ],
        ),
      ),
    );
  }
}

class ServiceAppointmentDetailsCardWidget extends StatelessWidget {
  final String title;
  final Widget subtitleWidget;
  final Widget? trailingIcon;

  ServiceAppointmentDetailsCardWidget({
    required this.subtitleWidget,
    required this.title,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avenir55RomanText(
          text: title,
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300.w,
              child: subtitleWidget,
            ),
            trailingIcon ?? SizedBox(),
          ],
        ),
        Divider(color: greyColor, thickness: 1),
      ],
    );
  }
}
