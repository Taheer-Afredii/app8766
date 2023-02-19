import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/service/localDatabase/local_db.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AppointmentSettings/AppointmentSettings.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessDrawer/BusnesUserDetails.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/CustomerFeedBackScreen/CustomerFeedBackScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyBusinessProfileScreen/MyBusinessProfileScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyBusinessProfileScreen/business_profile_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/MyServicesScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MySubscriptionScreen/MySubscriptionScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/ServiceSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BusinessDrawar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessProfileViewModel(),
      child:
          Consumer<BusinessProfileViewModel>(builder: (cotext, model, child) {
        BusinessUserDetails model2 = Provider.of<BusinessUserDetails>(context);
        return Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
              height: 1.sh,
              width: 290.w,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.r),
                  bottomRight: Radius.circular(35.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.h + ScreenUtil().statusBarHeight,
                      decoration: BoxDecoration(
                          color: darkGreyColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35.r),
                              bottomRight: Radius.circular(35.r))),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            model2.businessUser.image == null
                                ? CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: 60.r,
                                    child: kCircularProgress(),
                                  )
                                : CircleAvatar(
                                    radius: 60.r,
                                    backgroundImage: NetworkImage(
                                        model2.businessUser.image!),
                                  ),
                            // model.customerUserModel.image != null
                            //     ? CircleAvatar(
                            //         radius: 60.r,
                            //         backgroundImage: NetworkImage(
                            //             model.customerUserModel.image!),
                            //       )
                            //     : CircleAvatar(
                            //         radius: 60.r,
                            //         child: Icon(
                            //           Icons.person,
                            //           size: 60.sp,
                            //         ),
                            //       ),
                            SizedBox(height: 10.h),
                            avenir55RomanText(
                              text:
                                  model2.businessUser.businessName ?? "loading",
                              // model.customerUserModel.name!,
                              fontSize: 20.sp,
                              color: whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => MyBusinessProfileScreen());
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: myBusinessIcon,
                            title: "My Business",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                            Get.to(() => AppointmentSettings());
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: appointmentSettingIcon,
                            title: "Appointment Settings",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => MyServicesScreen());
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: myServicesIcon,
                            title: "My Services",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: myEventsIcon,
                            title: "My Events",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                            Get.to(() => MySubscriptionScreen());
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: subscriptionIcon,
                            title: "Subscription",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                            Get.to(() => CustomerFeedBackScreen());
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: drawerFavoriteServicesImage,
                            title: "Customers Feedback",
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          color: blackColor,
                          thickness: 1,
                          indent: 50.w,
                          endIndent: 50.w,
                        ),
                        SizedBox(height: 10.h),
                        BusinessDrawerItemsWidget(
                          onTap: () async {
                            Share.share(
                              'https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad&hl=en&gl=US&pli=1',
                            );
                          },
                          leadingIconImgae: drawerShareAppImage,
                          title: "Share App",
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: termsAndConditionIcon,
                            title: "Terms & Conditions",
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add function
                          },
                          child: BusinessDrawerItemsWidget(
                            leadingIconImgae: drawarAboutUsImage,
                            title: "About us",
                          ),
                        ),
                        SizedBox(height: Get.height / 10),
                        InkWell(
                          onTap: () async {
                            await LocalDB.removeBusinessUserRecord();
                            await Get.offAll(() => ServiceSelectionScreen());
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomGloballyUsedButtonWidget(
                              width: 180.w,
                              height: 50.h,
                              centerTitle: "Log Out",
                              color: redColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}

class BusinessDrawerItemsWidget extends StatelessWidget {
  final String leadingIconImgae;
  final String title;
  VoidCallback? onTap;

  BusinessDrawerItemsWidget({
    required this.leadingIconImgae,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Image.asset(
              leadingIconImgae,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 30.w),
            avenir55RomanText(
              text: title,
              fontSize: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
