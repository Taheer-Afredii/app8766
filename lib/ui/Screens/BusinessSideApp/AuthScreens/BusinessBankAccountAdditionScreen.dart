import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/auth_viewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/assets.dart';

class BusinessBankDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  avenir55RomanText(
                    text: "Enter Bank details",
                    fontSize: 22.sp,
                  ),
                  avenir55RomanText(
                    text: "Get Paid by customers",
                    fontSize: 17.sp,
                  ),
                  SizedBox(height: 20.h),
                  Image.asset(
                    creditCardImage,
                    width: 140.w,
                    height: 140.h,
                  ),
                  SizedBox(height: 20.h),
                  TextFieldwithTitleWidget(
                    textInputType: TextInputType.number,
                    controller: model.cardNumberController,
                    hintText: 'Enter your card number',
                    title: "Card number",
                  ),
                  SizedBox(height: 20.h),
                  TextFieldwithTitleWidget(
                    controller: model.cardNameController,
                    title: "Card Holder's Name",
                    hintText: 'Enter your card name',
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldwithTitleWidget(
                          controller: model.cardExpiryDateController,
                          title: "Exp. Date",
                          hintText: 'e.g 11/22',
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: TextFieldwithTitleWidget(
                          textInputType: TextInputType.number,
                          controller: model.cardCVVController,
                          title: "Enter CVV",
                          hintText: 'e.g 333',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  model.isLoading
                      ? kCircularProgress()
                      : GestureDetector(
                          onTap: () async {
                            await model.bankDetailstoFirebase();
                          },
                          child: CustomGloballyUsedButtonWidget(
                              centerTitle: "Next"),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
