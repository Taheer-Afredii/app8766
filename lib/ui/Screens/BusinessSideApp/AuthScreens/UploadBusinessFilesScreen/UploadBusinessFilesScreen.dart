import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/assets.dart';
import 'UploadBusinessFilesScreenModel.dart';

class BusinessUploadFileScreen extends StatefulWidget {
  BusinessUploadFileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessUploadFileScreen> createState() =>
      _BusinessUploadFileScreenState();
}

class _BusinessUploadFileScreenState extends State<BusinessUploadFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadBusinessFileViewModel>(
        builder: (context, model, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                avenir55RomanText(
                  text: "Upload Files",
                  fontSize: 22.sp,
                ),
                SizedBox(height: 5.h),
                avenir55RomanText(
                  text: "Kindly Upload the following Documents",
                  fontSize: 17.sp,
                ),
                SizedBox(height: 30.h),
                UploadFilesButtonWidget(
                  onPress: () async {
                    await model.pickFile();
                  },
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 400.h,
                  child: model.file != null && model.result!.files.length > 0
                      ? ListView.builder(
                          itemCount: model.result!.files.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              child: PDFFileList(
                                documentList: model.result!.files[index],
                                linerProgresswidget: LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  alignment: MainAxisAlignment.start,
                                  barRadius: Radius.circular(10.r),
                                  width: 230.w,
                                  lineHeight: 10.0,
                                  percent: model.progressValue[index],
                                  progressColor: greenColor,
                                ),
                                percentage: avenir55RomanText(
                                  text:
                                      "${(model.progressValue[index] * 100).toInt()} %",
                                  fontSize: 12.sp,
                                ),
                                sizeTextWidget: avenir55RomanText(
                                  text: model.result!.files[index].size > 1024
                                      ? '${(model.result!.files[index].size / 1024 / 1024).toStringAsFixed(2)} MB'
                                      : '${(model.result!.files[index].size / 1024).toStringAsFixed(2)} KB',
                                  fontSize: 13.sp,
                                  color: greenColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                removeFunction: () {
                                  setState(() {
                                    model.result!.files.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        )
                      : Text('No file selected'),
                ),
                model.isUploading
                    ? kCircularProgress()
                    : GestureDetector(
                        onTap: () async {
                          model.docUplaoding();
                        },
                        child:
                            CustomGloballyUsedButtonWidget(centerTitle: 'NEXT'),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UploadFilesButtonWidget extends StatelessWidget {
  VoidCallback onPress;
  UploadFilesButtonWidget({
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 170.h,
        width: 388.w,
        decoration: BoxDecoration(
          color: greenColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              color: greenColor,
              size: 50.sp,
            ),
            avenir55RomanText(
              text: "Upload Documents",
              color: greenColor,
              fontSize: 17.sp,
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: onPress,
              child: CustomGloballyUsedButtonWidget(
                width: 180.w,
                height: 30.h,
                centerTitle: 'Browse Files',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFFileList extends StatelessWidget {
  final PlatformFile documentList;
  Widget linerProgresswidget;
  VoidCallback removeFunction;
  Widget percentage;
  Widget sizeTextWidget;

  PDFFileList(
      {required this.documentList,
      required this.sizeTextWidget,
      required this.percentage,
      required this.removeFunction,
      required this.linerProgresswidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.r),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor,
            spreadRadius: 0.01,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(pdfIcon, width: 60.w, height: 60.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 220.w,
                child: avenir55RomanText(
                  text: documentList.name,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  linerProgresswidget,
                  SizedBox(width: 10.w),
                  percentage,
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: removeFunction,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: redColor),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 12.sp,
                        color: redColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              sizeTextWidget
            ],
          )
        ],
      ),
    );
  }
}
