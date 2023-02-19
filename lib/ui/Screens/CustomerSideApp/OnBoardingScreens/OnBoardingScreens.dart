import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/assets.dart';
import '../AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreens();
}

class _OnBoardingScreens extends State<OnBoardingScreens> {
  final controller = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: 600.h,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: controller,
                  children: [
                    OnBoardingScreenModel(
                      text: "Find near by services",
                      image: onBoardingImage1,
                    ),
                    OnBoardingScreenModel(
                      text: "Locate Near By Dentists",
                      image: onBoardingImage2,
                    ),
                    OnBoardingScreenModel(
                      text: "Hotels and Food services",
                      image: onBoardingImage3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              SmoothPageIndicator(
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
                count: 3,
                controller: controller,
                effect: ExpandingDotsEffect(
                  spacing: 8,
                  dotWidth: 13,
                  dotHeight: 13,
                  dotColor: Colors.black,
                  activeDotColor: greenColor,
                  expansionFactor: 1.1,
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  if (currentIndex == 2) {
                    print('SignIn Screen');
                    Get.to(() => CustomerSignUpScreen());
                  } else {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: CustomGloballyUsedButtonWidget(
                  centerTitle: currentIndex == 2 ? 'GET STARTED' : 'NEXT',
                ),
              ),
              SizedBox(height: 30.h),
              avenir55RomanText(
                text: "Are you a service provider?",
                fontSize: 20,
              ),
              InkWell(
                onTap: () {
                  //TODO: Add Business SignIn/Signup Screen here.
                },
                child: Text(
                  "Start Here",
                  style: GoogleFonts.averageSans(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: greenColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGloballyUsedButtonWidget extends StatelessWidget {
  final String centerTitle;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Color? centerFontColor;
  final double? centerFontSize;
  final Color? borderColor;

  CustomGloballyUsedButtonWidget(
      {required this.centerTitle,
      this.borderRadius,
      this.color,
      this.height,
      this.width,
      this.centerFontColor,
      this.centerFontSize,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 388.w,
      height: height ?? 62.h,
      decoration: BoxDecoration(
        color: color ?? greenColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 23.r),
      ),
      child: Center(
        child: avenir55RomanText(
          text: centerTitle,
          fontSize: centerFontSize ?? 20.sp,
          color: centerFontColor ?? whiteColor,
        ),
      ),
    );
  }
}

class OnBoardingScreenModel extends StatelessWidget {
  final String text;
  final String image;
  OnBoardingScreenModel({
    required this.image,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r)),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 50.h),
        avenir55RomanText(
          text: text,
          fontSize: 22.sp,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: 350.w,
          child: avenir55RomanText(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero id blandit.",
            fontSize: 17,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}



/*
 
*/
