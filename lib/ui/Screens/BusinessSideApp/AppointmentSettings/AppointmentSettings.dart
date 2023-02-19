import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentSettings extends StatefulWidget {
  @override
  State<AppointmentSettings> createState() => _AppointmentSettingsState();
}

class _AppointmentSettingsState extends State<AppointmentSettings> {
  bool multipleServices = true;
  bool payViaMobile = true;
  bool payInShop = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'Appointment Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appointmentSettingIcon,
              width: 144.w,
              height: 144.h,
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'Multiple Services',
                  fontSize: 18.sp,
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 388.w,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color: lightGreyColor,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: CircleBorder(),
                        fillColor: MaterialStateProperty.all(blackColor),
                        value: multipleServices,
                        onChanged: (value) {
                          setState(
                            () {
                              multipleServices = value!;
                            },
                          );
                        },
                      ),
                      avenir55RomanText(
                        text: 'Let\'s user chose multiple services',
                        fontSize: 16.sp,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'Let\'s get paid by',
                  fontSize: 18.sp,
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 388.w,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color: lightGreyColor,
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            shape: CircleBorder(),
                            fillColor: MaterialStateProperty.all(blackColor),
                            value: payViaMobile,
                            onChanged: (value) {
                              setState(
                                () {
                                  payViaMobile = value!;
                                },
                              );
                            },
                          ),
                          avenir55RomanText(
                            text: 'Pay via Mobile',
                            fontSize: 16.sp,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: CircleBorder(),
                            fillColor: MaterialStateProperty.all(blackColor),
                            value: payInShop,
                            onChanged: (value) {
                              setState(
                                () {
                                  payInShop = value!;
                                },
                              );
                            },
                          ),
                          avenir55RomanText(
                            text: 'Pay in Shop',
                            fontSize: 16.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.h),
            GestureDetector(
              onTap: () {
                //TODO: Add function here.
              },
              child: CustomGloballyUsedButtonWidget(centerTitle: 'SAVE'),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
