import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/service/localDatabase/customer_local_db.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/FavoriteScreen/FavoriteScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/PaymentMethodsScreen/PaymentMethodsScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/userDrawer_viewmodel.dart';
import 'package:app_876/ui/ServiceSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class UserDrawar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDrawerViewModel>(builder: (context, model, child) {
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
                          model.customerUserModel.image != null
                              ? CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: NetworkImage(
                                      model.customerUserModel.image.toString()),
                                )
                              : CircleAvatar(
                                  radius: 60.r,
                                  child: Icon(
                                    Icons.person,
                                    size: 60.sp,
                                  ),
                                ),
                          SizedBox(height: 10.h),
                          avenir55RomanText(
                            text: model.customerUserModel.name ?? "loading",
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
                          Get.to(() => FavoriteScreen());
                        },
                        child: DrawerItemsWidget(
                          leadingIconImgae: drawerFavoriteServicesImage,
                          title: "Favorites Services",
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => PaymentMethodsScreen());
                        },
                        child: DrawerItemsWidget(
                          leadingIconImgae: drawerPaymentMethodImage,
                          title: "Payment methods",
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
                      DrawerItemsWidget(
                        onTap: () async {
                          Share.share(
                              'https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad&hl=en&gl=US&pli=1');
                        },
                        leadingIconImgae: drawerShareAppImage,
                        title: "Share App",
                      ),
                      SizedBox(height: 20.h),
                      DrawerItemsWidget(
                        leadingIconImgae: drawarAboutUsImage,
                        title: "About us",
                      ),
                      SizedBox(height: Get.height / 5),
                      InkWell(
                        onTap: () async {
                          CustomerLocalDB.removeCustomerUserRecord();
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
    });
  }
}

class DrawerItemsWidget extends StatelessWidget {
  final String leadingIconImgae;
  final String title;
  VoidCallback? onTap;

  DrawerItemsWidget({
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
