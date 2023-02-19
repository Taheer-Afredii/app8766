import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/business_booking_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/UserDetailsScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessAwaitingRequestTabWidget extends StatelessWidget {
  // final String location;
  // final String showUpPercentage;
  // final List servicesList;
  // final String serviceTypeIcon;

  // BusinessAwaitingRequestTabWidget({
  //   required this.location,
  //   required this.serviceTypeIcon,
  //   required this.servicesList,
  //   required this.showUpPercentage,
  // });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessBookingViewModel(index: 2),
      child:
          Consumer<BusinessBookingViewModel>(builder: (coontext, model, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              model.awaitingLoading
                  ? SizedBox(height: 200.h, child: kCircularProgress())
                  : model.businessAwaitORdidnotArriveOrders.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50.h, horizontal: 100.w),
                          child: Text(
                            "No Awaiting Requests",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount:
                              model.businessAwaitORdidnotArriveOrders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: InkWell(
                                onTap: () {
                                  Get.to(UserDetailsScreen(
                                      data: model
                                              .businessAwaitORdidnotArriveOrders[
                                          index]));
                                },
                                child: AwaitingResponseCardWidget(
                                  model: model,
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
              SizedBox(height: 50.h),
            ],
          ),
        );
      }),
    );
  }
}

class AwaitingResponseCardWidget extends StatelessWidget {
  BusinessBookingViewModel model;
  int index;

  AwaitingResponseCardWidget(
      {super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(model
                        .businessAwaitORdidnotArriveOrders[index].userPic
                        .toString()),
                    //  NetworkImage(
                    //   model.businessUpcomingOrders[index].userPic!,
                    // ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avenir55RomanText(
                        text: model
                            .businessAwaitORdidnotArriveOrders[index].userName
                            .toString(),
                        // text: model.businessUpcomingOrders[index].userName!,
                        fontSize: 18.sp,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            pinIcon2,
                            width: 14.w,
                            height: 14.h,
                          ),
                          SizedBox(width: 5.w),
                          SizedBox(
                            width: 150.w,
                            child: avenir55RomanText(
                              text: model
                                  .businessAwaitORdidnotArriveOrders[index]
                                  .address
                                  .toString(),
                              // text: location,
                              fontSize: 13.sp,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  avenir55RomanText(text: 'Status:'),
                  SizedBox(width: 5.w),
                  avenir55RomanText(
                    text: 'Late',
                    // text: showUpPercentage,
                    color: redColor,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 5.h),
          Divider(color: blackColor),
          SizedBox(height: 5.h),
          Row(
            children: [
              avenir55RomanText(
                text: 'Appointment date: ',
                fontSize: 16.sp,
              ),
              avenir55RomanText(
                text: DateFormat('dd MMM yyyy')
                        .format(model
                            .businessAwaitORdidnotArriveOrders[index].date!
                            .toDate())
                        .toString() +
                    " - " +
                    "${model.businessAwaitORdidnotArriveOrders[index].timeSlot}",
                color: redColor,
                fontSize: 16.sp,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Divider(color: blackColor),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avenir55RomanText(
                text: 'Services Requested',
                fontSize: 16.sp,
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 60.h,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.businessAwaitORdidnotArriveOrders[index]
                      .Services!.length, // servicesList.length,
                  // servicesList.length,
                  itemBuilder: (BuildContext context, int innerIndex) {
                    return Row(
                      children: [
                        Image.asset(
                          // serviceTypeIcon,
                          chairIcon,
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 10.w),
                        avenir55RomanText(
                          text: model.businessAwaitORdidnotArriveOrders[index]
                              .Services![innerIndex]['serviceName']
                              .toString(), // servicesList[index]['serviceName']
                          // text: servicesList[index]['serviceName'],
                          fontSize: 16.sp,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  await model.markIsCompleted(
                      docid: model
                          .businessAwaitORdidnotArriveOrders[index].docId
                          .toString(),
                      customerId: model
                          .businessAwaitORdidnotArriveOrders[index].customeruid
                          .toString());
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 140.w,
                  height: 40.h,
                  centerTitle: 'Completed',
                  centerFontSize: 16.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.markIsDidNotArrive(model
                      .businessAwaitORdidnotArriveOrders[index].docId
                      .toString());
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 140.w,
                  height: 40.h,
                  centerTitle: 'Didn\'t Arrive',
                  centerFontSize: 16.sp,
                  color: redColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
