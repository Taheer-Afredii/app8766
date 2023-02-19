import 'dart:developer';

import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/business_signup_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/HomeScreenModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum DropDownType {
  serviceCategory,
  genderCategory,
  numberOfEmployees,
}

// ignore: must_be_immutable
class BusinessSignUpScreen extends StatefulWidget {
  @override
  State<BusinessSignUpScreen> createState() => _BusinessSignUpScreenState();
}

class _BusinessSignUpScreenState extends State<BusinessSignUpScreen> {
  // final List<String> serviceCategoryList = [
  final List<String> genderList = [
    'Male',
    'Female',
  ];

  final List<String> numberofEmployeesList = [
    '3-5',
    '6-10',
    '11-15',
    '16-20',
    '20-24',
  ];
  String countryCode = '';
  String finalPhoneNumber = '';

//phone validation
  final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,12}$');

  bool validatePhoneNumber(String phone) {
    return phoneRegex.hasMatch(phone);
  }

  //email validation
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  bool validateEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  //password validation
  bool validatePassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(password);
  }

  //website validation
  bool validateWebsite(String url) {
    String pattern =
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(url);
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessSignUpViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 1.sw,
                height: 260.h,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        model.coverImagepickImage(ImageSource.gallery);
                      },
                      child: model.coverImage != null
                          ? Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: darkGreyColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.r),
                                  bottomRight: Radius.circular(30.r),
                                ),
                              ),
                              child: Image.file(
                                model.coverImage!,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            )
                          : Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: darkGreyColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.r),
                                  bottomRight: Radius.circular(30.r),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: whiteColor,
                                    size: 60.sp,
                                  ),
                                  SizedBox(height: 20.h),
                                  avenir55RomanText(
                                      text: "Upload Background Banner",
                                      fontSize: 20.sp,
                                      color: whiteColor)
                                ],
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: -70.h,
                      child: InkWell(
                        onTap: () {
                          model.pickImage(ImageSource.gallery);
                        },
                        child: Column(
                          children: [
                            model.profileImage != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        FileImage(model.profileImage!),
                                    radius: 65.r,
                                  )
                                : Container(
                                    width: 130.w,
                                    height: 130.h,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: greyColor.withOpacity(0.2),
                                          spreadRadius: 0.1,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          color: greyColor,
                                          size: 40.sp,
                                        ),
                                        SizedBox(height: 5.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: avenir55RomanText(
                                            text: 'Upload Company Logo',
                                            fontSize: 12.sp,
                                            color: greyColor,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 90.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SafeArea(
                  top: false,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ServicesDropDownWidget(
                          items: serviceImage,
                          selectedItem: model.selectedDropdownItem,
                          onChanged: (item) {
                            model.getServiceCategory(item!);
                          },
                        ),
                        // CustomDropDownField(
                        //   leadingImage: serviceCategoryIcon,
                        //   hintText: 'Service Category',
                        //   title: 'Service Category',
                        //   Items: serviceCategoryList,
                        //   dropDownType: DropDownType.serviceCategory,
                        // ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          textFieldMaxLines: 1,
                          textInputType: TextInputType.text,
                          controller: model.businessnameController,
                          hintText: 'business name',
                          title: 'Business Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Business name is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          textFieldMaxLines: 1,
                          textInputType: TextInputType.number,
                          controller: model.businessNoController,
                          hintText: 'Registration number (opt)',
                          title: 'Business Reg. No.',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Registration Number Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomDropDownField(
                          leadingImage: genderSelectionIcon,
                          hintText: 'Male or Female',
                          title: 'Services for',
                          Items: genderList,
                          dropDownType: DropDownType.genderCategory,
                        ),
                        SizedBox(height: 20.h),
                        CustomDropDownField(
                          leadingImage: numberOfEmployeesIcon,
                          hintText: '3-5',
                          title: 'Number of employees',
                          Items: numberofEmployeesList,
                          dropDownType: DropDownType.numberOfEmployees,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: CountryCodePicker(
                                searchStyle: avenir55RomanStyle(),
                                initialSelection: 'United Kingdom',
                                textStyle: avenir55RomanStyle(),
                                textOverflow: TextOverflow.ellipsis,
                                onChanged: (value) {
                                  setState(() {
                                    countryCode = value.dialCode!;
                                  });
                                  print(
                                      "this is phone number ${countryCode + model.businessPhoneNumberController.text}");
                                },
                                boxDecoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                showFlagDialog: true,
                                showFlag: false,
                              ),
                            ),
                            TextFieldwithTitleWidget(
                              textInputType: TextInputType.phone,
                              width: 310.w,
                              title: 'Phone Number',
                              hintText: '398-981287-4',
                              controller: model.businessPhoneNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone Number is required".tr;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        // TextFieldwithTitleWidget(
                        //   textInputType: TextInputType.phone,
                        //   controller: model.businessPhoneNumberController,
                        //   hintText: 'Mobile/phone number',
                        //   title: 'Business Phone number',
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Please enter your phone number';
                        //     }
                        //     if (!validatePhoneNumber(value)) {
                        //       return 'Please enter a valid phone number';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          textInputType: TextInputType.emailAddress,
                          controller: model.businessEmailController,
                          hintText: 'Email',
                          title: 'Business Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!validateEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          controller: model.businessPasswordController,
                          hintText: 'Password',
                          title: 'Password',
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for signup".tr);
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)"
                                  .tr);
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          textInputType: TextInputType.url,
                          controller: model.businessWebsiteController,
                          hintText: 'www.yourbusiness.com',
                          title: 'Business Website',
                          validator: (value) {
                            if (validateWebsite(value!)) {
                              print('Valid website URL');
                            } else {
                              return 'Invalid website URL';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextFieldwithTitleWidget(
                          height: 100.h,
                          textFieldMaxLines: 4,
                          controller: model.businessDetailsController,
                          hintText: 'Business Details',
                          title: 'About business',
                        ),
                        SizedBox(height: 50.h),
                        model.loading == true
                            ? kCircularProgress()
                            : GestureDetector(
                                onTap: () async {
                                  log("${model.selectedDropdownItem}");
                                  log("model is loading ${model.isLoading}");
                                  if (model.profileImage == null &&
                                      model.coverImage == null) {
                                    Get.snackbar("Error", "Image are required");
                                  } else if (model.genderCategoryBool == null) {
                                    Get.snackbar(
                                        "Error", "Gender category is required");
                                  } else if (model.numberOfEmployeesBool ==
                                      null) {
                                    Get.snackbar(
                                        "Error", "Employee Number is required");
                                  } else if (model.genderCategoryBool == null) {
                                    Get.snackbar(
                                        "Error", "Gender category is required");
                                  } else {
                                    if (formKey.currentState!.validate()) {
                                      if (model.phoneList.contains(model
                                          .businessPhoneNumberController
                                          .text)) {
                                        Get.snackbar(
                                          'Error',
                                          'Phone Number already exists',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else if (model.emailList.contains(
                                          model.businessEmailController.text)) {
                                        Get.snackbar(
                                          'Error',
                                          'Email already exists',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        await model.phoneAuthentication();
                                      }
                                    }
                                  }
                                },
                                child: CustomGloballyUsedButtonWidget(
                                    centerTitle: model.isLoading == false
                                        ? 'NEXT'
                                        : "Loading"),
                              ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ServicesDropDownWidget extends StatefulWidget {
  final List<ServiceImages> items;
  final ServiceImages? selectedItem;
  final ValueChanged<ServiceImages?> onChanged;

  ServicesDropDownWidget({
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  _ServicesDropDownWidgetState createState() => _ServicesDropDownWidgetState();
}

class _ServicesDropDownWidgetState extends State<ServicesDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avenir55RomanText(
          text: 'Service Category',
          fontSize: 16.sp,
          color: blackColor.withOpacity(0.5),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 50.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: lightGreyColor,
          ),
          child: DropdownButton<ServiceImages>(
            hint: SizedBox(
              height: 30.h,
              child: Row(
                children: [
                  Image.asset(serviceListImage1),
                  SizedBox(width: 10),
                  Text('Adult Bars Entertainment'),
                ],
              ),
            ),
            underline: SizedBox(),
            isExpanded: true,
            value: widget.selectedItem,
            onChanged: widget.onChanged,
            items: widget.items.map((ServiceImages item) {
              return DropdownMenuItem<ServiceImages>(
                value: item,
                child: SizedBox(
                  height: 30.h,
                  child: Row(
                    children: [
                      Image.asset(item.image.toString()),
                      SizedBox(width: 10),
                      Text(item.imageName.toString()),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDropDownField extends StatefulWidget {
  final List<String> Items;
  final String leadingImage;
  final String hintText;
  final String title;
  final Enum dropDownType;
  CustomDropDownField({
    required this.Items,
    required this.leadingImage,
    required this.hintText,
    required this.title,
    required this.dropDownType,
  });

  @override
  State<CustomDropDownField> createState() => _CustomDropDownField();
}

class _CustomDropDownField extends State<CustomDropDownField> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<BusinessSignUpViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avenir55RomanText(
          text: widget.title,
          fontSize: 16.sp,
          color: blackColor.withOpacity(0.5),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: SizedBox(
                height: 30.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.leadingImage,
                      scale: 2.7,
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                        child: avenir55RomanText(
                      text: widget.hintText,
                      fontSize: 13.sp,
                    )),
                  ],
                ),
              ),
              items: widget.Items.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        avenir55RomanText(
                          text: item,
                          fontSize: 13.sp,
                        )
                      ],
                    ),
                  )).toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                switch (widget.dropDownType) {
                  case DropDownType.serviceCategory:
                    {
                      model.getServiceCategoryBool(value.toString());
                    }
                    break;

                  case DropDownType.genderCategory:
                    {
                      model.getGenderBool(value.toString());
                    }
                    break;

                  case DropDownType.numberOfEmployees:
                    {
                      model.getNumberOfEmployeesBool(value.toString());
                    }
                    break;
                }
                log(model.serviceCategoryBool.toString());
                log(model.genderCategoryBool.toString());
                log(model.numberOfEmployeesBool.toString());
              },

              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 35.sp,
              iconEnabledColor: blackColor,
              buttonHeight: 50.h,
              buttonWidth: 260.w,
              buttonPadding: EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: lightGreyColor,
              ),
              // dropdownOverButton: true,
              buttonElevation: 0,
              itemHeight: 40,
              itemPadding: EdgeInsets.symmetric(horizontal: 14.w),
              dropdownMaxHeight: 200.h,
              dropdownWidth: 260,
              dropdownPadding: EdgeInsets.only(left: 50.w),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: Colors.white,
              ),
              dropdownElevation: 8,
              scrollbarRadius: Radius.circular(25),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: false,
              offset: Offset(-20, 0),
            ),
          ),
        ),
      ],
    );
  }
}
