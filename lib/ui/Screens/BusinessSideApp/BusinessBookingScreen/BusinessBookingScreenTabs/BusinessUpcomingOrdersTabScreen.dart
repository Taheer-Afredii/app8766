import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/business_booking_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessChatScreen/BusinessChatScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessAppointmentCardModel {
  String name;
  DateTime appointmentDate;
  String profileImage;
  String serviceType;

  BusinessAppointmentCardModel({
    required this.appointmentDate,
    required this.name,
    required this.profileImage,
    required this.serviceType,
  });
}

List<BusinessAppointmentCardModel> appointmentCardList = [
  BusinessAppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  BusinessAppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  BusinessAppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  BusinessAppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  BusinessAppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
];

class BusinessUpcomingOrdersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessBookingViewModel(index: 1),
      child:
          Consumer<BusinessBookingViewModel>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: model.acceptedLoading
              ? SizedBox(height: 200.h, child: kCircularProgress())
              : model.businessAcceptedUpcomingOrder.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 50.h, horizontal: 100.w),
                      child: Text(
                        "No Upcoming Requests",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: model.businessAcceptedUpcomingOrder.length,
                          itemBuilder: (context, index) {
                            var data =
                                model.businessAcceptedUpcomingOrder[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => UserDetailsScreen(data: data));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 130.h,
                                        width: 6.w,
                                        decoration: BoxDecoration(
                                          color: yelloColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              bottomLeft:
                                                  Radius.circular(15.r)),
                                        ),
                                      ),
                                      BusinessAppointmentCardWidget(
                                        mainIndex: index,
                                        model: model,
                                        topRightCornerWidget: GestureDetector(
                                          onTap: () {
                                            Get.to(() => BusinessChatScreen(
                                                  name: data.userName!,
                                                  image: data.userPic!,
                                                  customerId: data.customeruid!,
                                                  businessId: data.businessuid!,
                                                  startlatituide:
                                                      data.businessLatitude!,
                                                  startlongitude:
                                                      data.businessLongitude!,
                                                  endlatitude: data.latitude!,
                                                  endlongitude: data.longitude!,
                                                ));
                                          },
                                          child: Image.asset(
                                            appointmentCardChatIcon,
                                            width: 30.w,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

class BusinessAppointmentCardWidget extends StatelessWidget {
  int mainIndex;
  final Widget topRightCornerWidget;

  BusinessBookingViewModel model;

  BusinessAppointmentCardWidget({
    required this.mainIndex,
    required this.topRightCornerWidget,
    required this.model,
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
                        //convert timestamp to date
                        text: DateFormat('dd MMM yyyy')
                                .format(model
                                    .businessAcceptedUpcomingOrder[mainIndex]
                                    .date!
                                    .toDate())
                                .toString() +
                            " - " +
                            "${model.businessAcceptedUpcomingOrder[mainIndex].timeSlot}",
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
                backgroundImage: NetworkImage(
                    model.businessAcceptedUpcomingOrder[mainIndex].userPic!),
              ),
              title: avenir55RomanText(
                text: model.businessAcceptedUpcomingOrder[mainIndex].userName!,
                fontSize: 17,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(
                    text: model.businessAcceptedUpcomingOrder[mainIndex]
                        .Services![0]["serviceName"],
                    fontSize: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: avenir55RomanText(
                          text: model.businessAcceptedUpcomingOrder[mainIndex]
                                      .Services!.length >=
                                  2
                              ? model.businessAcceptedUpcomingOrder[mainIndex]
                                  .Services![1]["serviceName"]
                              : "",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: model.businessAcceptedUpcomingOrder[mainIndex]
                                    .Services!.length >
                                2
                            ? "And More...."
                            : "",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  mapLaunch(
                      model.businessAcceptedUpcomingOrder[mainIndex].latitude
                          .toString(),
                      model.businessAcceptedUpcomingOrder[mainIndex].longitude
                          .toString());
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
