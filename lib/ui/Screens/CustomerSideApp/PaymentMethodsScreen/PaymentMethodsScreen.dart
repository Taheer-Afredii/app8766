import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'Payment methods'),
      body: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              SavedMethodCardWidget(
                cardNumber: '58** **** **** 4534',
                cardTypeImage: mastercardImage,
              ),
              SizedBox(height: 20.h),
              SavedMethodCardWidget(
                cardNumber: '48** **** **** 6732',
                cardTypeImage: visacardImage,
              ),
              SizedBox(height: 50.h),
              GestureDetector(
                onTap: () {
                  //TODO: Add payment method Function here.
                },
                child: CustomGloballyUsedButtonWidget(
                  centerTitle: 'Add Payment Method',
                  color: greenColor.withOpacity(0.1),
                  borderRadius: 50.r,
                  centerFontColor: greenColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SavedMethodCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardTypeImage;

  SavedMethodCardWidget({
    required this.cardNumber,
    required this.cardTypeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: ShapeDecoration(
        color: greenColor.withOpacity(0.4),
        shape: StadiumBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                width: 50.w,
                height: 50.h,
                cardTypeImage,
              ),
              SizedBox(width: 20.w),
              avenir55RomanText(
                text: cardNumber,
                fontSize: 20.sp,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    //TODO: Apply Remove function here
                  },
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: whiteColor,
                    child: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: redColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    //TODO: Apply Edit function here
                  },
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: whiteColor,
                    child: Icon(
                      Icons.edit,
                      size: 16.sp,
                      color: greenColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
