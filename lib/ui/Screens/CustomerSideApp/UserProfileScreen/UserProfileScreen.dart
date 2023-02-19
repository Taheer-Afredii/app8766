import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/CustomWidgets/TextFieldwithTitleWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserProfileScreen/DeleteAccountScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserProfileScreen/UserProfileViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: GeneralAppBarWidget(title: 'My Profile'),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        model.image != null
                            ? CircleAvatar(
                                backgroundColor: lightGreyColor,
                                radius: 55.r,
                                backgroundImage: FileImage(model.image!),
                              )
                            : model.user.image != null
                                ? CircleAvatar(
                                    backgroundColor: lightGreyColor,
                                    radius: 55.r,
                                    backgroundImage:
                                        NetworkImage(model.user.image!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: lightGreyColor,
                                    radius: 55.r,
                                    child: Icon(
                                      Icons.person,
                                      size: 50.sp,
                                    ),
                                  ),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: whiteColor,
                          child: IconButton(
                            icon: Icon(
                              color: blackColor,
                              Icons.camera_alt,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              model.pickImage(ImageSource.gallery);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.editNameTextController,
                      title: "FullName",
                      hintText: model.user.name ?? '',
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.editEmailTextController,
                      title: "Email",
                      hintText: model.user.email ?? '',
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.editPhoneTextController,
                      title: "Phone Number",
                      hintText: model.user.phoneNumber ?? '',
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.editAddressTextController,
                      title: "Address",
                      hintText: '12 ST Downtown, NY 90001',
                    ),
                    SizedBox(height: 20.h),
                    model.updateLoading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () {
                              model.updateuser();
                              Get.back();
                            },
                            child: CustomGloballyUsedButtonWidget(
                              centerTitle: 'UPDATE PROFILE',
                            ),
                          ),
                    SizedBox(height: 40.h),
                    // model.deleteLoading
                    //     ? kCircularProgress()
                    //     :

                    InkWell(
                      onTap: () async {
                        // model.deleteuser();
                        Get.to(() => DeleteAccountScreen());
                      },
                      child: avenir55RomanText(
                        text: "Delete Account",
                        fontSize: 19.sp,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              )),
        ),
      );
    });
  }
}
