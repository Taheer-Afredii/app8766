import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/BookingScreen/BookingScreenTabs/UserBookingScreenViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/CustomerChatScreen/CustomerChatScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceProviderDetailsScreen/ServiceProviderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentCardModel {
  String name;
  DateTime appointmentDate;
  String profileImage;
  String serviceType;

  AppointmentCardModel({
    required this.appointmentDate,
    required this.name,
    required this.profileImage,
    required this.serviceType,
  });
}

List<AppointmentCardModel> appointmentCardList = [
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
];

class UpcomingOrdersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserBookingViewModel(index: 1),
      child: Consumer<UserBookingViewModel>(builder: ((context, model, child) {
        return model.upcomingLoading
            ? kCircularProgress()
            : model.upcomingOrders.isEmpty
                ? Center(
                    child: Text("No Upcoming orders"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: model.upcomingOrders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ServiceProviderDetailsScreen(
                                      data: model.upcomingOrders[index]));
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
                                      UserUpComingWidget(
                                        data: model.upcomingOrders[index],
                                        model: model,
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
      })),
    );
  }
}

class UserUpComingWidget extends StatelessWidget {
  SelectedServiceModel data;
  UserBookingViewModel model;

  UserUpComingWidget({
    required this.data,
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
                        text: DateFormat('dd MMMM, yyyy')
                            .format(data.date!.toDate()),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => CustomerChatScreen(
                            name: data.businessName.toString(),
                            image: data.businessProfileImage.toString(),
                            businessId: data.businessuid.toString(),
                            customerId: data.customeruid.toString(),
                            startlatituide: data.latitude.toString(),
                            startlongitude: data.longitude.toString(),
                            endlatitude: data.businessLatitude.toString(),
                            endlongitude: data.businessLongitude.toString(),
                          ));
                    },
                    child: Image.asset(appointmentCardChatIcon,
                        width: 30.w, height: 30.h)),
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
                backgroundImage: NetworkImage(data.userPic!),
              ),
              title: avenir55RomanText(
                text: data.userName ?? "loading",
                fontSize: 17,
              ),
              subtitle: avenir55RomanText(
                text: data.Services![0]["serviceName"] ?? "loading",
                fontSize: 12,
              ),
              trailing: GestureDetector(
                onTap: () {
                  mapLaunch(data.businessLatitude.toString(),
                      data.businessLongitude.toString());
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
