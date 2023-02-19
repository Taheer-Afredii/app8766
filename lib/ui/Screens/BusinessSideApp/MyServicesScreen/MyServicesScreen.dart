import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/AddNewServiceViewModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/MyServicesViewModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyServicesScreen/Widgets/ServiceScreenCustomWidgets.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyServicesViewModel(),
      child: Consumer<MyServicesViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(title: 'My Services'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  BoostPostButton(),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 0.6.sh,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: model.services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: MyServicesCardWidget(
                            data: model.services[index],
                            model: model,
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddNewServicesScreenDrawer());
                    },
                    child: CustomGloballyUsedButtonWidget(
                      centerTitle: 'Add Service',
                      color: whiteColor,
                      centerFontColor: greenColor,
                      borderColor: greenColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AddNewServicesScreenDrawer extends StatefulWidget {
  @override
  State<AddNewServicesScreenDrawer> createState() =>
      _AddNewServicesScreenDrawer();
}

class _AddNewServicesScreenDrawer extends State<AddNewServicesScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewServiceViewModelDrawer(),
      child: Consumer<AddNewServiceViewModelDrawer>(
          builder: (context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(title: 'Add New Service'),
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
                            textInputType: TextInputType.number,
                            controller: model.serviceTimeController,
                            title: "Service time",
                            hintText: 'e.g. 20 min',
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: TextFieldwithTitleWidget(
                            textInputType: TextInputType.number,
                            controller: model.servicePriceController,
                            title: "Service Price",
                            hintText: 'e.g. \$ 10',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    model.loading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () async {
                              await model.addService();
                              Navigator.pop(context);
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
      }),
    );
  }
}

class EditService extends StatefulWidget {
  String docid;
  EditService({required this.docid});
  @override
  State<EditService> createState() => _EditService();
}

class _EditService extends State<EditService> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewServiceViewModelDrawer(),
      child: Consumer<AddNewServiceViewModelDrawer>(
          builder: (context, model, child) {
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
                            textInputType: TextInputType.number,
                            controller: model.serviceTimeController,
                            title: "Service time",
                            hintText: 'e.g. 20 min',
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: TextFieldwithTitleWidget(
                            textInputType: TextInputType.number,
                            controller: model.servicePriceController,
                            title: "Service Price",
                            hintText: 'e.g. \$ 10',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    model.loading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () async {
                              await model.editService(docid: widget.docid);
                              Navigator.pop(context);
                            },
                            child: CustomGloballyUsedButtonWidget(
                              centerTitle: "Edit Service",
                            ),
                          ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          )),
        );
      }),
    );
  }
}
