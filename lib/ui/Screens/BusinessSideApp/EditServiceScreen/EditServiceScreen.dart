import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/service_addition_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/assets.dart';

class EditServiceScreen extends StatefulWidget {
  @override
  State<EditServiceScreen> createState() => _EditServiceScreen();
}

class _EditServiceScreen extends State<EditServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceAdditionViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: GeneralAppBarWidget(title: 'Edit Service'),
        body: SingleChildScrollView(
            child: Container(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Image.asset(
                    addServicesImage,
                    width: 330.w,
                    height: 180.h,
                  ),
                  SizedBox(height: 20.h),
                  TextFieldwithTitleWidget(
                    controller: model.serviceNameController,
                    title: "Service Name",
                    hintText: 'Enter Service',
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldwithTitleWidget(
                          controller: model.serviceTimeController,
                          title: "Service time",
                          hintText: 'e.g. 20 min',
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: TextFieldwithTitleWidget(
                          controller: model.servicePriceController,
                          title: "Service Price",
                          hintText: 'e.g. \$ 10',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  model.isLoading
                      ? kCircularProgress()
                      : GestureDetector(
                          onTap: () async {
                            await model.addService();
                          },
                          child: CustomGloballyUsedButtonWidget(
                            centerTitle: "Add Service",
                          ),
                        ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
