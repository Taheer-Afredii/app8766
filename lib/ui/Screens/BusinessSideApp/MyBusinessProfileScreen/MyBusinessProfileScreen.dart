import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessEditProfile/BusinessEditProfile.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyBusinessProfileScreen/business_profile_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

TextEditingController businessProfileRegNoController = TextEditingController();
TextEditingController businessProfilePhoneNoController =
    TextEditingController();
TextEditingController businessProfileEmailController = TextEditingController();
TextEditingController businessProfileWebsiteController =
    TextEditingController();
TextEditingController businessProfileDetailsController =
    TextEditingController();

class MyBusinessProfileScreen extends StatefulWidget {
  @override
  State<MyBusinessProfileScreen> createState() => _MyBusinessProfileScreen();
}

class _MyBusinessProfileScreen extends State<MyBusinessProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessProfileViewModel(),
      child:
          Consumer<BusinessProfileViewModel>(builder: (context, model, child) {
        return Scaffold(
          body: model.businessUser.image == null
              ? kCircularProgress()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      MyBusinessProfileScreenAppBarWidget(
                        profileImage: model.businessUser.image,
                        coverImage: model.businessUser.coverImage,
                      ),
                      SizedBox(height: 80.h),
                      Column(
                        children: [
                          TextFieldwithTitleWidget(
                            controller: businessProfileRegNoController,
                            title: 'Business Reg No.',
                            hintText: model.businessUser.registrationNumber
                                .toString(),
                          ),
                          SizedBox(height: 20.h),
                          TextFieldwithTitleWidget(
                            controller: businessProfilePhoneNoController,
                            title: 'Business Phone number',
                            hintText: model.businessUser.phoneNumber.toString(),
                          ),
                          SizedBox(height: 20.h),
                          TextFieldwithTitleWidget(
                            controller: businessProfileEmailController,
                            title: 'Business Email',
                            hintText: model.businessUser.email.toString(),
                          ),
                          SizedBox(height: 20.h),
                          TextFieldwithTitleWidget(
                            controller: businessProfileWebsiteController,
                            title: 'Business Website',
                            hintText: model.businessUser.website.toString(),
                          ),
                          SizedBox(height: 20.h),
                          TextFieldwithTitleWidget(
                            textFieldMaxLines: 5,
                            height: 150.h,
                            controller: businessProfileDetailsController,
                            title: 'Business Details',
                            hintText:
                                model.businessUser.serviceDetails.toString(),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.to(MyBusinessEditProfileScreen());
                            },
                            child: CustomGloballyUsedButtonWidget(
                              color: whiteColor,
                              borderColor: greenColor,
                              centerFontColor: greenColor,
                              centerTitle: 'EDIT DETAILS',
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

//
//
//ScreenSpecificWidgets
//
//

//>>>>>>>>>>>>>>>>>>>>>//

//>>>>>>>>>>>>>>>>>>>>>//

class MyBusinessProfileScreenAppBarWidget extends StatefulWidget {
  String? profileImage;
  String? coverImage;

  MyBusinessProfileScreenAppBarWidget({
    this.profileImage,
    this.coverImage,
  });

  @override
  State<MyBusinessProfileScreenAppBarWidget> createState() =>
      _MyBusinessProfileScreenAppBarWidget();
}

class _MyBusinessProfileScreenAppBarWidget
    extends State<MyBusinessProfileScreenAppBarWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
              image: widget.coverImage != null
                  ? DecorationImage(
                      image: NetworkImage(widget.coverImage!),
                      fit: BoxFit.fitWidth)
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50.h,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 140.w,
                height: 140.h,
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  image: widget.profileImage != null
                      ? DecorationImage(
                          image: NetworkImage(widget.profileImage!),
                          fit: BoxFit.fitWidth)
                      : DecorationImage(
                          image: AssetImage(dummyPersonImage1),
                        ),
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    // searchModel.profileImage == ""
                    //     ? CircleAvatar(
                    //         radius: 65.r,
                    //         backgroundColor: whiteColor,
                    //         child: Icon(
                    //           Icons.person,
                    //           color: blackColor,
                    //           size: 20.sp,
                    //         ),
                    //       )
                    //     : Image.network(
                    //         searchModel.profileImage,
                    //         fit: BoxFit.fill,
                    //       ),

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
  }
}
