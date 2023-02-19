import 'dart:developer';

import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/business_signup_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/assets.dart';

class BusinessOTPVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  String verificationId;

  BusinessOTPVerificationScreen({
    required this.phoneNumber,
    required this.verificationId,
  });
  String otp = "";

  @override
  // bool isChecked = false;
  Widget build(BuildContext context) {
    return Consumer<BusinessSignUpViewModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Image.asset(
                    otpScreenAnimation,
                    width: 200.w,
                    height: 200.h,
                  ),
                  SizedBox(height: 50.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        avenir55RomanText(
                          text: "PhoneNumber",
                          fontSize: 16.sp,
                        ),
                        avenir55RomanText(
                          text: phoneNumber,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  avenir55RomanText(
                    text: "Enter OTP",
                    fontSize: 18,
                  ),
                  SizedBox(height: 10.h),
                  OtpTextField(
                    borderRadius: BorderRadius.circular(10.r),
                    numberOfFields: 6,
                    focusedBorderColor: greenColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      print("print code $code");
                    },
                    onSubmit: (String verificationCode) {
                      print("print code $verificationCode");
                      otp = verificationCode;
                    },
                  ),
                  SizedBox(height: 30.h),
                  model.otpLoading
                      ? kCircularProgress()
                      : GestureDetector(
                          onTap: () async {
                            log("print otp $otp");

                            await model.verifyOtp(
                              verificationId: verificationId,
                              otp: otp,
                            );
                          },
                          child: CustomGloballyUsedButtonWidget(
                              centerTitle: "VERIFY OTP"),
                        ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      model.phoneAuthentication();
                    },
                    child: avenir55RomanText(
                      text: "RESEND OTP",
                      fontSize: 20.sp,
                      color: greenColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
