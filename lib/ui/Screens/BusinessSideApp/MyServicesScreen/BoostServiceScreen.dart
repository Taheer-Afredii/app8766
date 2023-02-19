import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController boostAdTitleController = TextEditingController();
TextEditingController boostDiscountController = TextEditingController();

class BoostServiceScreen extends StatefulWidget {
  @override
  State<BoostServiceScreen> createState() => _BoostServiceScreenState();
}

class _BoostServiceScreenState extends State<BoostServiceScreen> {
  String? selectedAdDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'BOOST SERVICES'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                premiumIcon,
                width: 120.w,
                height: 120.h,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 370.w,
                child: avenir55RomanText(
                  text: 'Now it\'s time to boost your business services and get'
                      'more clients and more appointments. Your'
                      'services will be displayed as ads to user'
                      'based on their interest',
                  textAlign: TextAlign.center,
                  color: blackColor.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 20.h),
              TextFieldwithTitleWidget(
                controller: boostAdTitleController,
                hintText: 'Ad Title',
                title: 'Service Ad Title',
              ),
              SizedBox(height: 20.h),
              TextFieldwithTitleWidget(
                textInputType: TextInputType.number,
                controller: boostDiscountController,
                hintText: 'e.g. 25% off for first appointment',
                title: 'Discounts (Optional)',
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(
                    text: 'Ad Duration',
                    fontSize: 18.sp,
                  ),
                  Container(
                    width: 388.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              fillColor: MaterialStateProperty.all(blackColor),
                              value: 'weekAd',
                              groupValue: selectedAdDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedAdDuration = value.toString();
                                });
                              },
                            ),
                            avenir55RomanText(
                              text: '7 Days (\$10)',
                              fontSize: 18.sp,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              fillColor: MaterialStateProperty.all(blackColor),
                              value: 'monthAd',
                              groupValue: selectedAdDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedAdDuration = value.toString();
                                });
                              },
                            ),
                            avenir55RomanText(
                              text: '30 Days (\$40)',
                              fontSize: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  //TODO: Add ads function here.
                },
                child: CustomGloballyUsedButtonWidget(
                  centerTitle: 'PUBLISH AD (\$10)',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
