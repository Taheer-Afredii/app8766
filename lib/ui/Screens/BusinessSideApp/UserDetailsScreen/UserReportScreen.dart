import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/UserDetailsScreen/user_report_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

TextEditingController reportReasonController = TextEditingController();
TextEditingController reportIssueDetailsController = TextEditingController();

class UserReportScreen extends StatelessWidget {
  SelectedServiceModel data;
  UserReportScreen({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserReportViewModel(),
      child: Consumer<UserReportViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(title: 'Report ${data.userName}'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SizedBox(
                width: 1.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      warningORreportIcon,
                      color: greyColor,
                      height: 200.h,
                      width: 200.w,
                    ),
                    SizedBox(height: 50.h),
                    TextFieldwithTitleWidget(
                      controller: reportReasonController,
                      hintText: 'Reason',
                      title: 'Reason',
                    ),
                    SizedBox(height: 20.h),
                    TextFieldwithTitleWidget(
                      controller: reportIssueDetailsController,
                      hintText: 'Issue Details',
                      title: 'Issue Details',
                      textFieldMaxLines: 5,
                      height: 125.h,
                    ),
                    SizedBox(height: 100.h),
                    model.loading
                        ? kCircularProgress()
                        : GestureDetector(
                            onTap: () {
                              model.sendReport(
                                  customerId: data.customeruid,
                                  businessId: data.businessuid);
                            },
                            child: CustomGloballyUsedButtonWidget(
                                centerTitle: 'SUBMIT'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
