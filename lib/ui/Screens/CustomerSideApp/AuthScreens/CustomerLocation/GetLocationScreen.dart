import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerLocation/customer_get_location_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/customer_sign_up_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/GenderSelectionScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class GetLocationScreen extends StatelessWidget {
  bool? gender;
  String? phone;
  GetLocationScreen({super.key, required this.gender, required this.phone});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetCustomerLocationViewModel(),
      child: Consumer<GetCustomerLocationViewModel>(
          builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.loading,
          blur: 0.5,
          opacity: 0.5,
          child: Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: 1.sw,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        locationAnimation,
                        width: 300.w,
                        height: 300.h,
                      ),
                      SizedBox(height: 100.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: avenir55RomanText(
                          text: 'Turn on location',
                          fontSize: 30.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      avenir55RomanText(
                        text: 'Locate nearby services providers',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: () async {
                          await model.getLocation(context);
                          await model.updateLocation(
                              context: context, gender: gender, phone: phone);
                        },
                        child: CustomGloballyUsedButtonWidget(
                            centerTitle: 'ENABLE MY LOCATION'),
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          Get.to(() => GenderSelectionScreen());
                        },
                        child: CustomGloballyUsedButtonWidget(
                          centerFontColor: blackColor,
                          borderColor: blackColor,
                          color: Colors.transparent,
                          centerTitle: 'SKIP FOR NOW',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
