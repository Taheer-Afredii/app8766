import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/service_addition_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/styles.dart';
import 'WorkDaysRoutineScreen.dart';

class BusinessAddServicesScreen extends StatefulWidget {
  @override
  State<BusinessAddServicesScreen> createState() =>
      _BusinessAddServicesScreen();
}

final formKey = GlobalKey<FormState>();

class _BusinessAddServicesScreen extends State<BusinessAddServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceAdditionViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: SingleChildScrollView(
            child: Container(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    avenir55RomanText(
                      text: "Add Services",
                      fontSize: 23,
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(
                      addServicesImage,
                      width: 290.w,
                      height: 140.h,
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: model.serviceNameController,
                      title: "Service Name",
                      hintText: 'Enter Service',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "service name can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldwithTitleWidget(
                            textInputType: TextInputType.number,
                            controller: model.serviceTimeController,
                            title: "Service time",
                            hintText: 'e.g. 20 min',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "service time can't be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: TextFieldwithTitleWidget(
                            textInputType: TextInputType.number,
                            controller: model.servicePriceController,
                            title: "Service Price",
                            hintText: 'e.g. \$ 10',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "service price can't be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      textInputType: TextInputType.number,
                      controller: model.serviceDiscountController,
                      title: "Offer discount for the 1st appointment? (Opt.)",
                      hintText: 'e.g. \$ 10',
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Checkbox(
                          fillColor: MaterialStateProperty.all(greenColor),
                          value: model.isChecked,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            model.paidAfterService(value);
                            model.isChecked2 = false;
                          },
                        ),
                        avenir55RomanText(
                          text: "Get paid after service completion",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          fillColor: MaterialStateProperty.all(greenColor),
                          value: model.isChecked2,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            model.paidInAdvance(value);
                            model.isChecked = false;
                          },
                        ),
                        avenir55RomanText(
                          text: "Get paid in advance",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    model.isLoading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await model.addService();
                              }
                            },
                            child: CustomGloballyUsedButtonWidget(
                              color: Colors.transparent,
                              borderColor: greenColor,
                              centerTitle: "Add Service",
                              centerFontColor: greenColor,
                            ),
                          ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => WorkDaysRoutineScreen());
                      },
                      child:
                          CustomGloballyUsedButtonWidget(centerTitle: "Next"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      );
    });
  }
}
