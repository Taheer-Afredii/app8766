import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessFeedback/business_feedback_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/CustomerSignUpScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

String selectedTip = '';

class BusinessFeedbackScreen extends StatelessWidget {
  SelectedServiceModel data;

  BusinessFeedbackScreen({
    required this.data,
  });
  final List<String> tipsList = [
    'No Tip',
    '\$5',
    '\$10',
    '\$20',
  ];
  TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessFeedbackViewModel(),
      child:
          Consumer<BusinessFeedbackViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(title: 'Leave Feedback'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  CircleAvatar(
                    radius: 70.r,
                    backgroundImage: NetworkImage(data.userPic!),
                  ),
                  avenir55RomanText(
                    text: data.userName!,
                    fontSize: 24.sp,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: avenir55RomanText(
                      text:
                          'Your feedback will help service provider to improve services',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RatingBar.builder(
                    initialRating: model.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rate_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      model.onRatingChanged(rating);
                      print(rating);
                    },
                  ),
                  SizedBox(height: 10.h),
                  TextFieldwithTitleWidget(
                    height: 80.h,
                    textFieldMaxLines: 3,
                    controller: feedbackController,
                    hintText: 'Leave a feedback...',
                    title: '',
                  ),
                  SizedBox(height: 10.h),
                  DottedLine(),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avenir55RomanText(
                        text: 'Service Charges',
                        fontSize: 20.sp,
                      ),
                      avenir55RomanText(
                        text: '\$ ${data.totalAmount!.toStringAsFixed(0)}',
                        fontSize: 20.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  DottedLine(),
                  SizedBox(height: 30.h),
                  model.loading
                      ? kCircularProgress()
                      : GestureDetector(
                          onTap: () async {
                            await model.ratingToCustomerBYBusiness(
                                customerid: data.customeruid!,
                                docid: data.docId!,
                                reviewControler: feedbackController.text,
                                context: context);
                            feedbackController.clear();
                          },
                          child: CustomGloballyUsedButtonWidget(
                            centerTitle: 'SUBMIT',
                          ),
                        ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class TipCardWidget extends StatefulWidget {
  final String tipAmount;

  TipCardWidget({required this.tipAmount});

  @override
  State<TipCardWidget> createState() => _TipCardWidgetState();
}

class _TipCardWidgetState extends State<TipCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTip = widget.tipAmount;
          print(widget.tipAmount);
          print(selectedTip);
        });
      },
      child: Container(
        width: 75.w,
        height: 36.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: selectedTip == widget.tipAmount ? greenColor : lightGreyColor,
          border: Border.all(
            color: selectedTip == widget.tipAmount ? greenColor : greyColor,
          ),
        ),
        child: Center(
          child: avenir55RomanText(
            text: widget.tipAmount,
            color: selectedTip == widget.tipAmount ? whiteColor : blackColor,
          ),
        ),
      ),
    );
  }
}
