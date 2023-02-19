import 'dart:ffi';

import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController eventTypeController = TextEditingController();
TextEditingController eventTitleController = TextEditingController();
TextEditingController eventLocationController = TextEditingController();
TextEditingController eventAttireController = TextEditingController();
TextEditingController eventTicketPriceController = TextEditingController();
TextEditingController openingTimeController = TextEditingController();
TextEditingController closingTimeController = TextEditingController();
TextEditingController eventDateController = TextEditingController();
TextEditingController eventDetailsController = TextEditingController();

class CreateNewEventScreen extends StatelessWidget {
  const CreateNewEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // model.coverImagepickImage(ImageSource.gallery);
            },
            child:
                // model.coverImage != null
                //     ? Container(
                //         width: 1.sw,
                //         decoration: BoxDecoration(
                //           color: darkGreyColor,
                //           borderRadius: BorderRadius.only(
                //             bottomLeft: Radius.circular(30.r),
                //             bottomRight: Radius.circular(30.r),
                //           ),
                //         ),
                //         child: Image.file(
                //           model.coverImage!,
                //           fit: BoxFit.cover,
                //           filterQuality: FilterQuality.high,
                //         ),
                //       )
                //     :

                Container(
              width: 1.sw,
              height: 250.h,
              decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      color: whiteColor,
                      size: 60.sp,
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        avenir55RomanText(
                          text: "Upload Event Cover Picture",
                          fontSize: 20.sp,
                          color: whiteColor,
                        ),
                        SizedBox(height: 5.h),
                        avenir55RomanText(
                          text: "Set an attractive cover to attract customer",
                          fontSize: 12.sp,
                          color: whiteColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                TextFieldwithTitleWidget(
                  controller: eventTypeController,
                  hintText: 'Concert, Party, social gathering, festival etc..',
                  title: 'Event Type',
                ),
                TextFieldwithTitleWidget(
                  controller: eventTitleController,
                  hintText: 'Event title, e.g. sport, music, party event',
                  title: 'Event Title',
                ),
                TextFieldwithTitleWidget(
                  controller: eventLocationController,
                  hintText: 'Set event location',
                  title: 'Event Location',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldwithTitleWidget(
                      width: 166.w,
                      controller: eventAttireController,
                      hintText: 'Formal, informal',
                      title: 'Attire',
                    ),
                    TextFieldwithTitleWidget(
                      width: 166.w,
                      controller: eventTicketPriceController,
                      hintText: 'e.g. \$50',
                      title: 'Ticket Price',
                      textInputType: TextInputType.number,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldwithTitleWidget(
                      width: 166.w,
                      controller: openingTimeController,
                      hintText: 'Formal, informal',
                      title: 'Attire',
                    ),
                    TextFieldwithTitleWidget(
                      width: 166.w,
                      controller: closingTimeController,
                      hintText: 'e.g. \$50',
                      title: 'Ticket Price',
                      textInputType: TextInputType.number,
                    )
                  ],
                ),
                TextFieldwithTitleWidget(
                  width: 166.w,
                  controller: openingTimeController,
                  hintText: 'Set Event Date',
                  title: 'Event Date',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
