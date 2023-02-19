import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/HomeScreen/business_HomeScreen_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/UserReportScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestedUserDeatails extends StatelessWidget {
  List<SelectedServiceModel> services = [];
  int mainIndex;
  RequestedUserDeatails({
    super.key,
    required this.services,
    required this.mainIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessHomeScreenViewModel(),
      child: Consumer<BusinessHomeScreenViewModel>(
          builder: (context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(
            title: 'Customer Details',
            trailing: GestureDetector(
              onTap: () {
                Get.to(() => UserReportScreen(
                      data: services[mainIndex],
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
          body: model.businessUpcomingOrders.isEmpty
              ? Center(
                  child: avenir55RomanText(
                    text: 'No Request Found',
                    fontSize: 18.sp,
                  ),
                )
              : Padding(
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
                              backgroundImage:
                                  NetworkImage(services[mainIndex].userPic!),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                avenir55RomanText(
                                  text: services[mainIndex].userName!,
                                  fontSize: 18.sp,
                                ),
                                avenir55RomanText(
                                  text: services[mainIndex].address!,
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
                                      .format(
                                          services[mainIndex].date!.toDate())
                                      .toString() +
                                  " - " +
                                  "${services[mainIndex].timeSlot}",
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
                          itemCount: services[mainIndex].Services!.length,
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
                                  text: services[mainIndex].Services![index]
                                      ["serviceName"]!,
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
                              text: services[mainIndex].address!,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                        trailingIcon: GestureDetector(
                          onTap: () async {
                            //open map through url launcher
                            final long = services[mainIndex].longitude;
                            final lat = services[mainIndex].latitude;
                            final url =
                                'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                width: 25.w,
                                height: 25.h,
                                sendMessageFlyIcon,
                              ),
                              SizedBox(height: 5.h),
                              avenir55RomanText(
                                  text: 'Direction', fontSize: 12.sp),
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
                                  '\$ ${services[mainIndex].totalAmount}  ${services[mainIndex].mobilePay == true ? "(Pay via Mobile App)" : "(Pay on site)"} ',
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      model.acceptLoading
                          ? kCircularProgress()
                          : GestureDetector(
                              onTap: () async {
                                await model.acceptOrder(
                                    getback: true,
                                    docid: services[mainIndex].docId!);
                              },
                              child: CustomGloballyUsedButtonWidget(
                                  centerTitle: 'ACCEPT REQUEST')),
                      SizedBox(height: 20.h),
                      model.rejectLoading
                          ? kCircularProgress()
                          : GestureDetector(
                              onTap: () async {
                                await model.removeOrder(
                                    getback: true,
                                    docid: services[mainIndex].docId!);
                              },
                              child: CustomGloballyUsedButtonWidget(
                                centerTitle: 'REMOVE REQUEST',
                                borderColor: redColor,
                                color: whiteColor,
                                centerFontColor: redColor,
                              ),
                            ),
                    ],
                  ),
                ),
        );
      }),
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
