import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessBankAccountAdditionScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkDaysRoutineScreen extends StatefulWidget {
  @override
  State<WorkDaysRoutineScreen> createState() => _WorkDaysRoutineScreen();
}

class _WorkDaysRoutineScreen extends State<WorkDaysRoutineScreen> {
  BusinessUserModel businessUserModel = BusinessUserModel();
  // TextFeildata assigndata = TextFeildata();
  bool isChecked = false;
  bool islOading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avenir55RomanText(
                  text: "Set Weekly Duties hours",
                  fontSize: 22.sp,
                ),
                SizedBox(height: 20.h),
                Image.asset(
                  workingTimeImage,
                  width: 140.w,
                  height: 140.h,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: avenir55RomanText(
                        text: "Days",
                        fontSize: 16.sp,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: avenir55RomanText(
                        text: "From",
                        fontSize: 16.sp,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: avenir55RomanText(
                        text: "To",
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: DutyDays(days: days[index], index: index),
                    );
                  },
                ),
                SizedBox(height: 50.h),
                islOading
                    ? kCircularProgress()
                    : GestureDetector(
                        onTap: () async {
                          log("selectedDaysSchedule: ${selectedDaysSchedule[0].startingTime}");
                          setState(() {
                            islOading = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var uid = prefs.getString('buid');
                          //add data to firebase as map
                          await FirebaseFirestore.instance
                              .collection('BusinessUsers')
                              .doc(uid)
                              .collection("workRoutine")
                              .doc(uid)
                              .set({
                            'duty_days': selectedDaysSchedule
                                .map((e) => {
                                      'day': e.day,
                                      'starting_time': e.startingTime,
                                      'ending_time': e.endingTime,
                                      'is_closed': e.isClosed,
                                    })
                                .toList(),
                          });
                          setState(() {
                            islOading = false;
                          });
                          await Get.to(() => BusinessBankDetailScreen());
                        },
                        child:
                            CustomGloballyUsedButtonWidget(centerTitle: "Next"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

class DutyDaysModel {
  String startingTime;
  String endingTime;
  String day;
  bool isClosed;

  DutyDaysModel({
    required this.day,
    required this.startingTime,
    required this.endingTime,
    required this.isClosed,
  });
}

List<DutyDaysModel> selectedDaysSchedule = [
  DutyDaysModel(
    day: "Monday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Tuesday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Wednesday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Thursday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Friday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Saturday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
  DutyDaysModel(
    day: "Sunday",
    startingTime: '9:30 AM',
    endingTime: '6:30 PM',
    isClosed: false,
  ),
];

class DutyDays extends StatefulWidget {
  final String days;
  final int index;

  DutyDays({
    required this.days,
    required this.index,
  });

  @override
  State<DutyDays> createState() => _DutyDaysState();
}

enum TimeType {
  startingTime,
  endingTime,
}

class _DutyDaysState extends State<DutyDays> {
  DateFormat outputFormat = DateFormat('hh:mm a');

  bool isClosed = false;

  TimeOfDay startingTime = TimeOfDay(hour: 9, minute: 30);
  TimeOfDay endingTime = TimeOfDay(hour: 18, minute: 30);

  Future<void> startingTimeFunction(BuildContext context) async {
    TimeOfDay? picked1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked1 != null && picked1 != startingTime) {
      setState(() {
        startingTime = picked1;
        isClosed = false;
        selectedDaysSchedule[widget.index].startingTime = outputFormat.format(
          DateTime(0, 0, 0, startingTime.hour, startingTime.minute),
        );
      });
    }
  }

  Future<void> endingTimeFunction(BuildContext context) async {
    TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked2 != null && picked2 != endingTime) {
      setState(() {
        endingTime = picked2;
        isClosed = false;
        selectedDaysSchedule[widget.index].endingTime = outputFormat.format(
          DateTime(0, 0, 0, endingTime.hour, endingTime.minute),
        );
      });
    }
  }

  void showDialogueFunction(context, Enum type) {
    showDialog(
      context: context,
      builder: (ctxt) => Dialog(
        child: Container(
          width: 300.w,
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              avenir55RomanText(
                text: 'Pick your availability',
                fontSize: 24.sp,
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                  isClosed = false;
                  switch (type) {
                    case TimeType.startingTime:
                      {
                        startingTimeFunction(context);
                      }
                      break;

                    case TimeType.endingTime:
                      {
                        endingTimeFunction(context);
                      }
                      break;
                  }
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 150.w,
                  height: 50.h,
                  centerTitle: 'Pick Time',
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Get.back();
                    isClosed = true;
                    selectedDaysSchedule[widget.index].isClosed = true;
                  });
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 150.w,
                  height: 50.h,
                  centerTitle: 'Closed',
                  color: redColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              avenir55RomanText(
                text: widget.days,
                fontSize: 20.sp,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialogueFunction(context, TimeType.startingTime);
          },
          child: Container(
            alignment: Alignment.center,
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: avenir55RomanText(
              text: isClosed
                  ? 'Closed'
                  : outputFormat.format(
                      DateTime(0, 0, 0, startingTime.hour, startingTime.minute),
                    ),
              fontSize: 18.sp,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        GestureDetector(
          onTap: () {
            showDialogueFunction(context, TimeType.endingTime);
          },
          child: Container(
            alignment: Alignment.center,
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: avenir55RomanText(
              text: isClosed
                  ? 'Closed'
                  : outputFormat.format(
                      DateTime(0, 0, 0, endingTime.hour, endingTime.minute),
                    ),
              fontSize: 18.sp,
            ),
          ),
        ),
      ],
    );
  }
}
