import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/mapLauncher.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/BookingScreen/BookingScreenTabs/UserBookingScreenViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/FeedbackScreen/FeedbackScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompletedOrdersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserBookingViewModel(index: 3),
      child: Consumer<UserBookingViewModel>(builder: (index, model, child) {
        return model.completedLoading
            ? kCircularProgress()
            : model.completedOrders.isEmpty
                ? Center(
                    child: Text("No Upcoming Orders"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: model.completedOrders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: InkWell(
                                onTap: () {},
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
                                      UserCompletedTabbarWidget(
                                        data: model.completedOrders[index],
                                        model: model,
                                        topRightCornerWidget: index.isEven
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(() => FeedbackScreen(
                                                        uid: model
                                                            .completedOrders[
                                                                index]
                                                            .businessuid,
                                                        name: model
                                                            .completedOrders[
                                                                index]
                                                            .businessName,
                                                        image: model
                                                            .completedOrders[
                                                                index]
                                                            .businessProfileImage,
                                                        docid: model
                                                            .completedOrders[
                                                                index]
                                                            .docId,
                                                        totalAmount: model
                                                            .completedOrders[
                                                                index]
                                                            .totalAmount!
                                                            .toStringAsFixed(0),
                                                      ));
                                                },
                                                child: avenir55RomanText(
                                                  text:
                                                      'Rate your experience ->',
                                                  fontSize: 10.sp,
                                                  color: greenColor,
                                                ),
                                              )
                                            : CustomGloballyUsedButtonWidget(
                                                width: 125.w,
                                                height: 30.h,
                                                centerTitle: 'Payoff Now',
                                                centerFontSize: 15.sp,
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

class UserCompletedTabbarWidget extends StatelessWidget {
  SelectedServiceModel data;
  UserBookingViewModel model;
  Widget topRightCornerWidget;

  UserCompletedTabbarWidget({
    required this.topRightCornerWidget,
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
                  mapLaunch(
                    data.businessLatitude.toString(),
                    data.businessLongitude.toString(),
                  );
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
