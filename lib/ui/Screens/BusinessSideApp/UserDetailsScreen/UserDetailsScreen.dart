import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/UserReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends StatelessWidget {
  SelectedServiceModel data;
  UserDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(
        title: 'Customer Details',
        trailing: GestureDetector(
          onTap: () {
            Get.to(() => UserReportScreen(
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
                    backgroundImage: NetworkImage(data.userPic!),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      avenir55RomanText(
                        text: data.userName!,
                        fontSize: 18.sp,
                      ),
                      avenir55RomanText(
                        text: data.address!,
                        fontSize: 12.sp,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            UserAppointmentDetailsCardWidget(
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
                    text: DateFormat('dd MMM yyyy')
                            .format(data.date!.toDate())
                            .toString() +
                        " - " +
                        "${data.timeSlot}",
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            UserAppointmentDetailsCardWidget(
              title: 'Requested Services',
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
                        text: data.Services![index]["serviceName"],
                        maxLines: 2,
                        fontSize: 16.sp,
                      ),
                    ],
                  );
                },
              ),
            ),
            UserAppointmentDetailsCardWidget(
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
                    text: data.address!,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              trailingIcon: GestureDetector(
                onTap: () {
                  mapLaunch(
                      data.latitude.toString(), data.longitude.toString());
                },
                child: Column(
                  children: [
                    Image.asset(
                      width: 25.w,
                      height: 25.h,
                      sendMessageFlyIcon,
                    ),
                    SizedBox(height: 5.h),
                    avenir55RomanText(text: 'Direction', fontSize: 12.sp),
                  ],
                ),
              ),
            ),
            UserAppointmentDetailsCardWidget(
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
          ],
        ),
      ),
    );
  }
}

class UserAppointmentDetailsCardWidget extends StatelessWidget {
  final String title;
  final Widget subtitleWidget;
  final Widget? trailingIcon;

  UserAppointmentDetailsCardWidget({
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
