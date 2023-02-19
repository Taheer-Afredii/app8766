import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController deleteAccountEmailController = TextEditingController();
TextEditingController deleteAccountPasswordController = TextEditingController();
TextEditingController deleteAccountReasonController = TextEditingController();
TextEditingController deleteAccountDescriptionController =
    TextEditingController();

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'Delete my Account'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Center(
                child: Image.asset(
                  deleteAccountPersonImage,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
              SizedBox(height: 30.h),
              avenir55RomanText(
                text: 'We are really sorry to see you going like this, '
                    'Please make sure to complete all the  active appointments with barbers '
                    'and payoff them. Your feedback below will be appreciated.',
                fontSize: 16.sp,
              ),
              SizedBox(height: 20.h),
              avenir55RomanText(
                text: 'Verify its you!',
                fontSize: 20.sp,
              ),
              SizedBox(height: 10.h),
              TextFieldwithTitleWidget(
                controller: deleteAccountEmailController,
                hintText: 'user@email.com',
                title: 'Email',
              ),
              SizedBox(height: 10.h),
              TextFieldwithTitleWidget(
                controller: deleteAccountPasswordController,
                hintText: 'Your Password',
                title: 'Password',
              ),
              SizedBox(height: 20.h),
              avenir55RomanText(
                text: 'Please let\'s us know',
                fontSize: 20.sp,
              ),
              SizedBox(height: 20.h),
              TextFieldwithTitleWidget(
                controller: deleteAccountReasonController,
                hintText: 'State the reason...',
                title: 'Reason for deleting account',
              ),
              SizedBox(height: 10.h),
              TextFieldwithTitleWidget(
                height: 100.h,
                textFieldMaxLines: 3,
                controller: deleteAccountDescriptionController,
                hintText: 'Enter details....',
                title: 'Add description',
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  //TODO: Add delete Function here
                },
                child: CustomGloballyUsedButtonWidget(
                  centerTitle: 'DELETE ACCOUNT',
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
