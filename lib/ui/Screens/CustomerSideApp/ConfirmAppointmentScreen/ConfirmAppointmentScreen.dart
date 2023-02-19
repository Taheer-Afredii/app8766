import 'dart:developer';

import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ConfirmAppointmentScreen/confirmAppointmentViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/shopScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

List<AvailableTimeSlots> timeSlots = [];

class AvailableTimeSlots {
  DateTime time;
  bool isAvailable;

  AvailableTimeSlots({
    required this.isAvailable,
    required this.time,
  });
}

// timeSlotFunction({context, buid}) async {
//   timeSlots.clear();
//   ConfirmAppointmentViewModel model =
//       Provider.of<ConfirmAppointmentViewModel>(context, listen: false);
//   Duration step = Duration(minutes: 30);
//   await FirebaseFirestore.instance
//       .collection("BusinessUsers")
//       .doc(buid)
//       .collection("workRoutine")
//       .doc(buid)
//       .get()
//       .then((value) {
//     List data = value.data()!['duty_days'];
//     for (var i = 0; i < data.length; i++) {
//       // log("${DateFormat('EEEE').format(model.today)}");

//       if (data[i]['day'] == DateFormat('EEEE').format(model.today)) {
//         log("${data[i]['starting_time']}");
//         log(">>>>>>>>>>>>>>>>>>>");

//         DateTime startTime =
//             DateFormat("HH:mm a").parse(data[i]['starting_time']);
//         DateTime endTime = DateFormat("HH:mm a").parse(data[i]['ending_time']);

//         //convert to 24 hour format

//         log(" start${startTime}");
//         log(" end ${endTime}");
//         log("${startTime.isBefore(endTime)}");

//         while (startTime.isBefore(endTime)) {
//           log(">>>>>>>>>>>>>>>>>>>while");
//           DateTime timeIncrement = startTime.add(step);
//           timeSlots.add(
//             AvailableTimeSlots(
//               isAvailable: true,
//               time: DateFormat.Hm().format(timeIncrement),
//             ),
//           );
//           startTime = timeIncrement;
//         }
//       }
//     }
//     log("${timeSlots.length}");
//   });

//   // while (startTime.isBefore(endTime)) {
//   //   DateTime timeIncrement = startTime.add(step);
//   //   timeSlots.add(
//   //     AvailableTimeSlots(
//   //       isAvailable: true,
//   //       time: DateFormat.Hm().format(timeIncrement),
//   //     ),
//   //   );
//   //   startTime = timeIncrement;
//   // }
// }

class ConfirmAppointmentScreen extends StatefulWidget {
  double totAmount = 0;
  String serviceName = '';
  List selectedServices = [];
  String buid = '';
  ConfirmAppointmentScreen(
      {required this.serviceName,
      required this.buid,
      required this.totAmount,
      required this.selectedServices});
  @override
  State<ConfirmAppointmentScreen> createState() =>
      _ConfirmAppointmentScreenState();
}

class _ConfirmAppointmentScreenState extends State<ConfirmAppointmentScreen> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConfirmAppointmentViewModel>(context, listen: false)
          .timeSlotFunction(context: context, buid: widget.buid);
    });
  }

  bool isSelected = false;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<ServiceSearchScreenViewmodel>(context);
    var shopModel = Provider.of<ShopScreenViewModel>(context);
    ConfirmAppointmentViewModel model =
        Provider.of<ConfirmAppointmentViewModel>(context);

    return Scaffold(
      appBar: GeneralAppBarWidget(
        title: 'Confirm Appointment',
        ontap: () {
          model.mobilePay = false;
          model.sitePay = false;
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    child: Image.asset(dummyPersonImage1),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avenir55RomanText(
                        text: "${searchModel.name}" "${searchModel.category}/s",
                        fontSize: 18.sp,
                      ),
                      SizedBox(height: 3.h),
                      avenir55RomanText(
                        text: widget.serviceName,
                        fontSize: 14.sp,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 25.h),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(
                    text: 'Service List',
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                        itemCount: widget.selectedServices.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: ConfirmPaymentOfferedServicesCardWidget(
                              index: index,
                              service: widget.selectedServices,
                            ),
                          );
                        }),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CustomGloballyUsedButtonWidget(
                  color: lightGreyColor,
                  centerFontColor: greenColor,
                  borderColor: greenColor,
                  height: 50.h,
                  centerTitle: 'Add More Services',
                ),
              ),
              SizedBox(height: 20.h),
              avenir55RomanText(
                text: 'Select Date & Time',
                fontSize: 18.sp,
              ),
              SizedBox(height: 10.h),
              CustomCalenderWidget(),
              SizedBox(height: 15.h),
              avenir55RomanText(
                text: 'Available Slots',
                fontSize: 18.sp,
              ),
              SizedBox(height: 10.h),
              model.loading
                  ? kCircularProgress()
                  : timeSlots.isEmpty
                      ? avenir55RomanText(
                          text: "Closed", color: redColor, fontSize: 16.sp)
                      : Center(
                          child: Container(
                              height: 40.h,
                              width: 1.sw,
                              child: ListView.builder(
                                itemCount: timeSlots.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: model.reservedTimeSlots
                                            .contains(timeSlots[index].time)
                                        ? () {
                                            Get.snackbar(
                                              'Error',
                                              'This slot is already reserved',
                                            );
                                          }
                                        : () {
                                            if (!model.selectedTimeSlots
                                                .contains(
                                                    timeSlots[index].time)) {
                                              setState(() {
                                                model.selectedTimeSlots.clear();
                                                model.selectedTimeSlots
                                                    .add(timeSlots[index].time);
                                              });
                                            } else {
                                              setState(() {
                                                model.selectedTimeSlots.remove(
                                                    timeSlots[index].time);
                                              });
                                            }
                                            //one selection at a time
                                          },
                                    child: Container(
                                      width: 100.w,
                                      height: 40.h,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: model.reservedTimeSlots
                                                .contains(timeSlots[index].time)
                                            ? greyColor
                                            : model.selectedTimeSlots.contains(
                                                    timeSlots[index].time)
                                                ? greenColor
                                                : whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: model.reservedTimeSlots
                                                  .contains(
                                                      timeSlots[index].time)
                                              ? greyColor
                                              : model.selectedTimeSlots
                                                      .contains(
                                                          timeSlots[index].time)
                                                  ? greenColor
                                                  : greyColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: avenir55RomanText(
                                          text: DateFormat.Hm()
                                              .format(timeSlots[index].time),
                                          color: model.reservedTimeSlots
                                                  .contains(
                                                      timeSlots[index].time)
                                              ? whiteColor
                                              : model.selectedTimeSlots
                                                      .contains(
                                                          timeSlots[index].time)
                                                  ? whiteColor
                                                  : greenColor,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
              SizedBox(height: 20.h),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.5,
                dashLength: 15.w,
                dashColor: greyColor,
                dashGapLength: 10.w,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  avenir55RomanText(
                    text: 'Total',
                    fontSize: 20.sp,
                  ),
                  avenir55RomanText(
                    text:
                        '\$${Provider.of<ConfirmAppointmentViewModel>(context, listen: true).totalAmount}',
                    fontSize: 20.sp,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              avenir55RomanText(
                text: 'Payment method',
                fontSize: 18.sp,
              ),
              SizedBox(height: 20.h),
              Container(
                height: 50.h,
                padding: EdgeInsets.only(right: 20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: blackColor,
                          value: model.mobilePay,
                          onChanged: model.selectedTimeSlots.isEmpty
                              ? (value) {
                                  Get.snackbar(
                                    'Error',
                                    'Please select a time slot',
                                  );
                                }
                              : (value) {
                                  model.isMobilepay(value!);
                                  model.makePayment(
                                    buid: widget.buid,
                                    context: context,
                                    totalAmount:
                                        model.totalAmount.toStringAsFixed(0),
                                    selectedServices: widget.selectedServices,
                                    businessLatitude: searchModel.latitude,
                                    businessLongitude: searchModel.longitude,
                                    businessName: searchModel.name,
                                    businessProfileImage:
                                        searchModel.profileImage,
                                  );
                                },
                          side: BorderSide(
                              color: blackColor.withOpacity(0.5), width: 1.0),
                          shape: const CircleBorder(),
                        ),
                        const Text("Pay via Mobile")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: blackColor,
                          value: model.sitePay,
                          onChanged: (value) {
                            model.isSitepay(value!);
                          },
                          shape: const CircleBorder(),
                          side: BorderSide(
                              color: blackColor.withOpacity(0.5), width: 1.0),
                        ),
                        const Text("Pay on site")
                      ],
                    ),

                    //two buttons pay viw mobile and pay on site
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              model.selectServiceToFirebaseLoading
                  ? kCircularProgress()
                  : GestureDetector(
                      onTap: model.selectedTimeSlots.isNotEmpty
                          ? model.sitePay == true
                              ? () async {
                                  log("confirm appointment");
                                  await model.selctedServiceToFirebase(
                                      businessName: searchModel.name,
                                      businessProfileImage:
                                          searchModel.profileImage,
                                      businessLongitude: searchModel.longitude,
                                      businessLatitude: searchModel.latitude,
                                      buid: widget.buid,
                                      selectedServices: widget.selectedServices,
                                      stripeId: "sitePay");
                                }
                              : () {
                                  Get.snackbar(
                                    'Error',
                                    'Please select a payment method',
                                    colorText: whiteColor,
                                    backgroundColor: greenColor,
                                  );
                                }
                          : () {
                              Get.snackbar(
                                'Error',
                                'Please select a time slot ',
                                colorText: whiteColor,
                                backgroundColor: greenColor,
                              );
                            },
                      child: CustomGloballyUsedButtonWidget(
                          centerTitle: 'CONTINUE'),
                    ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCalenderWidget extends StatefulWidget {
  @override
  State<CustomCalenderWidget> createState() => _CustomCalenderWidgetState();
}

class _CustomCalenderWidgetState extends State<CustomCalenderWidget> {
  //Use this video for reference
  //https://www.youtube.com/watch?v=TDerNqLEpPE&list=PLvbIUhnkcQMS6QyLrEVZUStF8T2m0qjwf&ab_channel=ReactBits%28DamodarLohani%29

  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    ServiceSearchScreenViewmodel searchModel =
        Provider.of<ServiceSearchScreenViewmodel>(context, listen: false);
    ConfirmAppointmentViewModel model =
        Provider.of<ConfirmAppointmentViewModel>(context, listen: false);
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: greenColor,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: avenir55RomanStyle(
          color: greenColor,
          fontSize: 16.sp,
        ),
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: greenColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
        titleCentered: true,
        titleTextStyle: avenir55RomanStyle(
          color: greenColor,
          fontSize: 16.sp,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          color: greenColor,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          color: greenColor,
        ),
      ),
      onDaySelected: (DateTime day, DateTime focusedDay) async {
        await model.onDaySelected(day, focusedDay);
        await model.timeSlotFunction(context: context, buid: searchModel.buid);
        await model.getServices();
      },
      selectedDayPredicate: (day) => isSameDay(day, model.today),
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
    );
  }
}

//confirm  service list
class ConfirmPaymentOfferedServicesCardWidget extends StatefulWidget {
  int index;
  List service;

  ConfirmPaymentOfferedServicesCardWidget({
    super.key,
    required this.service,
    required this.index,
  });

  @override
  State<ConfirmPaymentOfferedServicesCardWidget> createState() =>
      _CondirmPaymentOfferedServicesCardWidget();
}

class _CondirmPaymentOfferedServicesCardWidget
    extends State<ConfirmPaymentOfferedServicesCardWidget> {
  bool serviceCheckBoxBool = false;

  @override
  Widget build(BuildContext context) {
    ShopScreenViewModel shopModel = Provider.of<ShopScreenViewModel>(context);
    return Container(
      width: 388.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: lightGreyColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: avenir55RomanText(
                  text: widget.service[widget.index]['serviceName'],
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 5.h),
              avenir55RomanText(
                text: "${widget.service[widget.index]['serviceTime']} min",
                fontSize: 12.sp,
              ),
            ],
          ),
          avenir55RomanText(
              text: '\$${widget.service[widget.index]["servicePrice"]}',
              fontSize: 18.sp),
        ],
      ),
    );
  }
}
