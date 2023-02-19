import 'dart:developer';

import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/BusinessHomeScreenAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessDrawer/BusinessDrawer.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessDrawer/BusnesUserDetails.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/HomeScreen/business_HomeScreen_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/HomeScreen/requested_user_details.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

List<String> appointmentServicesList = [
  'Man\'s New Haircut',
  'Shiny Haircoloring',
];

class BusinessHomeScreen extends StatefulWidget {
  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreen();
}

class _BusinessHomeScreen extends State<BusinessHomeScreen> {
  final TextEditingController businessHomeScreenSearchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessHomeScreenViewModel(),
      child: Consumer<BusinessHomeScreenViewModel>(
          builder: (context, model, child) {
        BusinessUserDetails model2 = Provider.of<BusinessUserDetails>(context);
        return Scaffold(
          drawer: BusinessDrawar(),
          appBar: BusinessHomeScreenAppBarWidget(
            centerWidget: avenir55RomanText(
              text: 'Home',
              color: whiteColor,
              fontSize: 22.sp,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  avenir55RomanText(
                    text: 'My Dashboard',
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  MyWalletCardWidget(),
                  SizedBox(height: 20.h),
                  avenir55RomanText(
                    text: 'Awaiting request',
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 10.h),
                  model.loading
                      ? SizedBox(height: 200, child: kCircularProgress())
                      : model.businessUpcomingOrders.isEmpty
                          ? SizedBox(
                              height: 200.h,
                              child: Center(
                                  child: avenir55RomanText(
                                text: 'No Requests Found',
                                fontSize: 18.sp,
                              )),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: model.businessUpcomingOrders.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => RequestedUserDeatails(
                                          services:
                                              model.businessUpcomingOrders,
                                          mainIndex: index,
                                        ),
                                      );
                                    },
                                    child: AwaitingRequestsCardWidget(
                                      model: model,
                                      index: index,
                                      location: '07 ST downtown, willow brook',
                                      showUpPercentage: '98%',
                                      servicesList: model
                                          .businessUpcomingOrders[index]
                                          .Services!,
                                      serviceTypeIcon: chairIcon,
                                    ),
                                  ),
                                );
                              }),
                            )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AwaitingRequestsCardWidget extends StatelessWidget {
  int index;
  BusinessHomeScreenViewModel model;
  final String location;
  final String showUpPercentage;
  final List servicesList;
  final String serviceTypeIcon;

  AwaitingRequestsCardWidget({
    required this.index,
    required this.model,
    required this.location,
    required this.serviceTypeIcon,
    required this.servicesList,
    required this.showUpPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 5,
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
                    backgroundImage: NetworkImage(
                      model.businessUpcomingOrders[index].userPic!,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avenir55RomanText(
                        text: model.businessUpcomingOrders[index].userName!,
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
                              text: location,
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
                  avenir55RomanText(text: 'Show up:'),
                  avenir55RomanText(text: showUpPercentage, color: greenColor),
                ],
              )
            ],
          ),
          SizedBox(height: 5.h),
          Divider(color: blackColor),
          SizedBox(height: 5.h),
          Row(
            children: [
              Image.asset(
                serviceTypeIcon,
                width: 45.w,
                height: 45.h,
              ),
              SizedBox(width: 20.w),
              SizedBox(
                height: 60.h,
                width: 200.w,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: servicesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10.sp,
                        ),
                        SizedBox(width: 10.w),
                        avenir55RomanText(
                          text: servicesList[index]['serviceName'],
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
                onTap: () {
                  model.acceptOrder(
                      getback: false,
                      docid: model.businessUpcomingOrders[index].docId!);
                  log("docid >>>>>>>>>>>>>${model.businessUpcomingOrders.length}}");
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 140.w,
                  height: 40.h,
                  centerTitle: 'Accept Request',
                  centerFontSize: 16.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.removeOrder(
                      getback: false,
                      docid: model.businessUpcomingOrders[index].docId!);
                },
                child: CustomGloballyUsedButtonWidget(
                  width: 140.w,
                  height: 40.h,
                  centerTitle: 'Remove Request',
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

class MyWalletCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          myWalletBackgroundImage,
          width: 388.w,
          height: 160.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SizedBox(
            height: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avenir55RomanText(
                  text: 'My Wallet',
                  fontSize: 18.sp,
                  color: whiteColor,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      avenir55RomanText(
                        text: '\$185.00',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                      SizedBox(height: 5.h),
                      avenir55RomanText(
                        text: 'Personal Balance',
                        color: greyColor,
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          myWalletVisaLogoImage,
                          width: 42.w,
                          height: 14.h,
                        ),
                        avenir55RomanText(
                          text: '**** 4534',
                          color: whiteColor,
                        )
                      ],
                    ),
                    Container(
                      width: 86.w,
                      height: 25.h,
                      decoration: ShapeDecoration(
                        shape: StadiumBorder(
                          side: BorderSide(color: whiteColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          avenir55RomanText(
                            text: 'Withdrawal',
                            color: whiteColor,
                            fontSize: 10.sp,
                          ),
                          Icon(
                            Icons.restore,
                            color: whiteColor,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
