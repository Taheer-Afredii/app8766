import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/AddWEmployViewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/business_signup_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BottomNavScreen/MainBusinessBottomNavigationBar.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BusinessProfileCompletScreen extends StatefulWidget {
  BusinessProfileCompletScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileCompletScreen> createState() =>
      _BusinessProfileCompletScreenState();
}

class _BusinessProfileCompletScreenState
    extends State<BusinessProfileCompletScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    BusinessSignUpViewModel model =
        Provider.of<BusinessSignUpViewModel>(context);
    BusinessAddEmployProvider addEmplyModel =
        Provider.of<BusinessAddEmployProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Center(
                child: Image.asset(
                  insideAppLogo,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
              SizedBox(height: 30.h),
              Icon(
                Icons.check_circle,
                color: greenColor,
                size: 150.sp,
              ),
              SizedBox(height: 30.h),
              avenir55RomanText(
                text: "Business Profile Completed",
                fontSize: 22,
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 300.w,
                child: avenir55RomanText(
                  text:
                      "Your have successfully create business/services profile now you can get cusomters",
                  fontSize: 17.sp,
                  textAlign: TextAlign.center,
                  color: greyColor,
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: 300.w,
                child: avenir55RomanText(
                  text:
                      "In order to use our platform for providing your services you must read & agree with terms",
                  fontSize: 17.sp,
                  textAlign: TextAlign.center,
                  color: greyColor,
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    // fillColor: baseColor,
                    fillColor: MaterialStateProperty.all(greenColor),
                    value: isChecked,
                    shape: const CircleBorder(),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                        ),
                        text: 'I have read & agree with ',
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: GoogleFonts.averageSans(
                                fontSize: 13.sp, color: greenColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              model.dataLoading || addEmplyModel.addEmployLoading
                  ? kCircularProgress()
                  : GestureDetector(
                      onTap: () async {
                        if (isChecked == true) {
                          await model.userAllDataToFirebase();
                          await addEmplyModel.addEmployee(
                              uid: model.busineesUid);
                          await await Get.offAll(
                              () => MainBusinessBottomNavigationBar());
                        } else {
                          Get.snackbar(
                              "Error", "Please agree with terms & conditions");
                        }
                      },
                      child:
                          CustomGloballyUsedButtonWidget(centerTitle: "Done"),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
