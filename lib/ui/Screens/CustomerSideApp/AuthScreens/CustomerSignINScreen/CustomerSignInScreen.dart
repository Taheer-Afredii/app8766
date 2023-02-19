import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignINScreen/customer_signin_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/assets.dart';
import '../CustomerSignUPScreen/CustomerSignUpScreen.dart';

class CustomerSignInScreen extends StatefulWidget {
  @override
  State<CustomerSignInScreen> createState() => _CustomerSignInScreen();
}

class _CustomerSignInScreen extends State<CustomerSignInScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CustomerSignInViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    insideAppLogo,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                SizedBox(height: 20.h),
                avenir55RomanText(
                  text: 'Login Account',
                  fontSize: 25.sp,
                ),
                SizedBox(height: 18.h),
                TextFieldwithTitleWidget(
                  textInputType: TextInputType.emailAddress,
                  title: 'Email',
                  hintText: 'user@email.com',
                  controller: model.emailTextController,
                ),
                SizedBox(height: 23.h),
                SizedBox(height: 23.h),
                TextFieldwithTitleWidget(
                  textInputType: TextInputType.visiblePassword,
                  title: 'Password',
                  hintText: 'Enter Password',
                  controller: model.passwordTextController,
                ),
                SizedBox(height: 20.h),
                model.isLoading
                    ? kCircularProgress()
                    : GestureDetector(
                        onTap: () async {
                          await model.signIn();
                        },
                        child: CustomGloballyUsedButtonWidget(
                            centerTitle: 'SIGN IN'),
                      ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    //TODO: Add forgot password function
                  },
                  child: Center(
                    child: avenir55RomanText(
                      text: 'Forgot Password?',
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: avenir55RomanText(
                    text: 'Don\'t have an account so for?',
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => CustomerSignUpScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10.w),
                      avenir55RomanText(
                        text: 'SIGN UP',
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
