import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/appointment_card_widget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/business_booking_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessFeedback/businessFeedBackScree.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BusinessCompletedOrdersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessBookingViewModel(index: 3),
      child:
          Consumer<BusinessBookingViewModel>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              model.completedLoading
                  ? SizedBox(height: 200.h, child: kCircularProgress())
                  : model.businessCompletedOrders.isEmpty
                      ? SizedBox(
                          height: 200, child: Text("No Completed Orders"))
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: model.businessCompletedOrders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => UserDetailsScreen(
                                      data: model
                                          .businessCompletedOrders[index]));
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
                                      AppointmentCardWidget(
                                          model: model
                                              .businessCompletedOrders[index],
                                          topRightCornerWidget: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => BusinessFeedbackScreen(
                                                        data: model
                                                                .businessCompletedOrders[
                                                            index],
                                                      ));
                                            },
                                            child: avenir55RomanText(
                                              text: 'Rate your experience ->',
                                              fontSize: 10.sp,
                                              color: greenColor,
                                            ),
                                          )),
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
