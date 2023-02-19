import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BusinessSubscriptionScreen extends StatefulWidget {
  BusinessSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<BusinessSubscriptionScreen> createState() =>
      _BusinessSubscriptionScreenState();
}

class _BusinessSubscriptionScreenState
    extends State<BusinessSubscriptionScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.subscriptionLoading,
        opacity: 0.5,
        blur: 0.5,
        child: Scaffold(
          body: SingleChildScrollView(
              child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: avenir55RomanText(
                    text: "Subscriptions",
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 250.w,
                  child: avenir55RomanText(
                    text:
                        "Select package plan to continue, and publish your services",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                ),
                Lottie.asset(animation2),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    model.subscriptionToFirebase(
                      monthlySubscription: true,
                      yearlySubscription: false,
                      autoRenewal: isChecked,
                    );
                  },
                  child: Container(
                    height: 110.h,
                    width: 388.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(monthlySubscriptionImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        avenir55RomanText(
                          text: "Monthly",
                          fontSize: 23.sp,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            avenir55RomanText(
                              text: "\$150 ",
                              fontSize: 17.sp,
                            ),
                            avenir55RomanText(
                              text: "/ Month",
                              fontSize: 17.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        avenir55RomanText(
                          text: "10 Services/Products",
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    model.subscriptionToFirebase(
                      monthlySubscription: false,
                      yearlySubscription: true,
                      autoRenewal: isChecked,
                    );
                  },
                  child: Container(
                    height: 120.h,
                    width: 388.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(yearlySubscriptionImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            avenir55RomanText(
                              text: "Annually",
                              fontSize: 23.sp,
                              color: whiteColor,
                            ),
                            avenir55RomanText(
                              text: "\$1,704",
                              fontSize: 23,
                              color: whiteColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            avenir55RomanText(
                              text: "\$142",
                              fontSize: 17,
                              color: whiteColor,
                            ),
                            avenir55RomanText(
                              color: lightGreyColor,
                              text: " / Month",
                              fontSize: 17,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        avenir55RomanText(
                          color: whiteColor,
                          text: "15 Services/Products",
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(greenColor),
                      value: isChecked,
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: avenir55RomanText(
                        text:
                            "Auto renewal (Subscription will be auto renewed base on your package plan)",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
