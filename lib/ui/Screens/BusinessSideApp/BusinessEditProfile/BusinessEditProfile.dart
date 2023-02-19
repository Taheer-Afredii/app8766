import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessEditProfile/BusinessEditProfileViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyBusinessEditProfileScreen extends StatefulWidget {
  @override
  State<MyBusinessEditProfileScreen> createState() =>
      _MyBusinessEditProfileScreen();
}

class _MyBusinessEditProfileScreen extends State<MyBusinessEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessEditProfileViewModel(),
      child: Consumer<BusinessEditProfileViewModel>(
          builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                MyBusinessEditProfileScreenAppBarWidget(),
                SizedBox(height: 80.h),
                Column(
                  children: [
                    TextFieldwithTitleWidget(
                      controller: model.businessProfileRegNoController,
                      title: 'Business Reg No.',
                      hintText:
                          model.businessUser.registrationNumber.toString(),
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.businessProfilePhoneNoController,
                      title: 'Business Phone number',
                      hintText: model.businessUser.phoneNumber.toString(),
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.businessProfileEmailController,
                      title: 'Business Email',
                      hintText: model.businessUser.email.toString(),
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.businessProfileWebsiteController,
                      title: 'Business Website',
                      hintText: model.businessUser.website.toString(),
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      textFieldMaxLines: 5,
                      height: 150.h,
                      controller: model.businessProfileDetailsController,
                      title: 'Business Details',
                      hintText: model.businessUser.serviceDetails.toString(),
                    ),
                    SizedBox(height: 20.h),
                    model.updateLoading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () async {
                              await model.updateProfile();
                            },
                            child: CustomGloballyUsedButtonWidget(
                              color: whiteColor,
                              borderColor: greenColor,
                              centerFontColor: greenColor,
                              centerTitle: 'UPDATE PROFILE',
                            ),
                          ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MyBusinessEditProfileScreenAppBarWidget extends StatefulWidget {
  @override
  State<MyBusinessEditProfileScreenAppBarWidget> createState() =>
      _MyBusinessEditProfileScreenAppBarWidget();
}

class _MyBusinessEditProfileScreenAppBarWidget
    extends State<MyBusinessEditProfileScreenAppBarWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessEditProfileViewModel>(
        builder: (context, model, child) {
      return SizedBox(
        width: 1.sw,
        height: 220.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 1.sw,
              height: 230.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
                image: model.coverImage != null
                    ? DecorationImage(
                        image: FileImage(model.coverImage!),
                        fit: BoxFit.fitWidth)
                    : model.businessUser.image != null
                        ? DecorationImage(
                            image: NetworkImage(model.businessUser.image!),
                            fit: BoxFit.contain)
                        : DecorationImage(
                            image: AssetImage(dummyPersonImage1),
                          ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.arrow_back,
                          color: blackColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.coverPickImage(
                          ImageSource.gallery,
                        );
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.edit,
                          color: blackColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -50.h,
              child: GestureDetector(
                onTap: () {
                  model.profileImagePickImage(ImageSource.gallery);
                },
                child: Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    image: model.profileImage != null
                        ? DecorationImage(
                            image: FileImage(model.profileImage!),
                            fit: BoxFit.fitWidth)
                        : model.businessUser.image != null
                            ? DecorationImage(
                                image: NetworkImage(model.businessUser.image!),
                                fit: BoxFit.fitWidth)
                            : DecorationImage(
                                image: AssetImage(dummyPersonImage1),
                              ),
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: blackColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, color: whiteColor, size: 20.sp),
                            SizedBox(height: 5.h),
                            avenir55RomanText(
                              text: 'Update Profile',
                              color: whiteColor,
                              fontSize: 12.sp,
                            )
                          ],
                        ),
                      ),

                      //TODO: Put condition here according to condition of premium
                      Positioned(
                        bottom: -15.h,
                        child: Image.asset(
                          premiumIcon,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
