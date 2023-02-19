import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentCardWidget extends StatelessWidget {
  SelectedServiceModel model;
  final Widget topRightCornerWidget;

  AppointmentCardWidget({
    required this.model,
    required this.topRightCornerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: 360.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avenir55RomanText(
              text: 'Appointment Date',
              fontSize: 12.sp,
            ),
            SizedBox(height: 7.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      darwarAppointmentImage,
                      width: 15.w,
                      height: 15.h,
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 150.w,
                      child: avenir55RomanText(
                        text: DateFormat('dd MMM yyyy')
                                .format(model.date!.toDate())
                                .toString() +
                            " - " +
                            "${model.timeSlot}",
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                topRightCornerWidget,
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 0,
              color: blackColor,
              indent: 20.w,
              endIndent: 20.w,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 22.r,
                backgroundImage: NetworkImage(model.userPic!),
              ),
              title: avenir55RomanText(
                text: model.userName!,
                fontSize: 17,
              ),
              subtitle: avenir55RomanText(
                text: model.Services![0]["serviceName"]!,
                fontSize: 12,
              ),
              trailing: GestureDetector(
                onTap: () {
                  mapLaunch(
                      model.latitude.toString(), model.longitude.toString());
                },
                child: Image.asset(
                  appointmentCardLocationIcon,
                  width: 30.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
