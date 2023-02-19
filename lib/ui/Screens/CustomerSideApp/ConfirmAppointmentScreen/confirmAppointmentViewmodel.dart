import 'dart:convert';
import 'dart:developer';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/BottomNavScreens/MainUserBottomNavigationBar.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ConfirmAppointmentScreen/ConfirmAppointmentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfirmAppointmentViewModel extends ChangeNotifier {
  Map<String, dynamic>? paymentIntentData;
  CustomerUserModel user = CustomerUserModel();

  double totalAmount = 0;
  List<DateTime> selectedTimeSlots = [];
  ConfirmAppointmentViewModel() {
    CustomerFirebaseService().customerFromFirebase(user).then((value) {
      user = value;
      notifyListeners();
    });
    getServices();
  }

  bool mobilePay = false;
  bool sitePay = false;
  isMobilepay(value) {
    mobilePay = value;
    sitePay = false;
    notifyListeners();
  }

  isSitepay(value) {
    sitePay = value;
    mobilePay = false;
    notifyListeners();
  }

  getTotalAmount(int value) {
    totalAmount = totalAmount + value;
    notifyListeners();
  }

  DateTime today = DateTime.now();
  onDaySelected(
    DateTime day,
    DateTime focusedDay,
  ) {
    today = day;
    notifyListeners();
  }

  bool loading = false;
  timeSlotFunction({context, buid}) async {
    log("time slot function");
    loading = true;
    notifyListeners();

    timeSlots.clear();
    ConfirmAppointmentViewModel model =
        Provider.of<ConfirmAppointmentViewModel>(context, listen: false);

    Duration step = Duration(minutes: 30);
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(buid)
        .collection("workRoutine")
        .doc(buid)
        .get()
        .then((value) {
      List data = value.data()!['duty_days'];
      for (var i = 0; i < data.length; i++) {
        // log("${DateFormat('EEEE').format(model.today)}");

        if (data[i]['day'] == DateFormat('EEEE').format(model.today)) {
          if (data[i]["is_closed"] == false) {
            DateTime startTime =
                DateFormat("HH:mm a").parse(data[i]['starting_time']);
            DateTime endTime =
                DateFormat("HH:mm a").parse(data[i]['ending_time']);

            //convert to 24 hour format

            log("${startTime.isBefore(endTime)}");

            while (startTime.isBefore(endTime)) {
              log(">>>>>>>>>>>>>>>>>>>while");
              DateTime timeIncrement = startTime.add(step);
              timeSlots.add(
                AvailableTimeSlots(
                  isAvailable: true,
                  time: timeIncrement,
                ),
              );
              startTime = timeIncrement;
              notifyListeners();
            }
          } else {
            log("is closed");
          }
        }
      }
    });

    loading = false;
    notifyListeners();
  }

  List serviceListFromFirebase = [];
  DateTime? timeslot;
  List reservedTimeSlots = [];
  getServices() async {
    reservedTimeSlots.clear();
    log("querying firebase for services");
    log(DateFormat('EEEE').format(today).toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .collection("selectedServices")
        .where("day", isEqualTo: DateFormat('EEEE').format(today).toString())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        serviceListFromFirebase.add(element.data());
      });
    }).then((value) {
      for (int i = 0; i < serviceListFromFirebase.length; i++) {
        reservedTimeSlots.add((serviceListFromFirebase[i]['timeSlot'][0]));
        log("reservedTimeSlots ${reservedTimeSlots.toString()}");

        // //convert hour to date time

      }
    });
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Stripe Payment>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  bool paymentLoading = false;
  Future<void> makePayment(
      {context,
      totalAmount,
      selectedServices,
      businessName,
      businessProfileImage,
      buid,
      businessLatitude,
      businessLongitude}) async {
    paymentLoading = true;

    notifyListeners();

    try {
      paymentIntentData = await createPaymentIntent(totalAmount, 'USD');
      //id = paymentIntentData!['id'];
      var id = paymentIntentData!['id'];
      var token = paymentIntentData!['client_secret'];
      var token2 = paymentIntentData!['token'];
      log("token ${token2}>>>>>>>>>>>>>>>");
      log(" id ${id}>>>>>>>>>>>>>>>");

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              //apple pay
              googlePay: const PaymentSheetGooglePay(
                  merchantCountryCode: "US",
                  currencyCode: "USD",
                  testEnv: true),
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              merchantDisplayName: "Ali"));
      //get token from stripe

      await displayPaymentSheet(context);
      await selctedServiceToFirebase(
          businessName: businessName,
          businessProfileImage: businessProfileImage,
          businessLongitude: businessLongitude,
          businessLatitude: businessLatitude,
          buid: buid,
          selectedServices: selectedServices,
          stripeId: id ?? '');

      paymentLoading = false;
      mobilePay = false;
      notifyListeners();
    } catch (e) {
      paymentLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      paymentIntentData = null;
      notifyListeners();
    } on StripeException catch (e) {
      log(e.toString());
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled"),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //add bank method

      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card"
      };
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                'Bearer =sk_test_51LVaiXGVj1b6RabbJKqp89wRd5x7o7kbQrNowOArcg9oEThuCwUDnIC4rcGGJzRMIvgIc3K4whpGjBVXLVjb1O8W00q7dCUr6K',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      mobilePay = false;
      notifyListeners();
      log(e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

//>>>>>>>> selected Services to firebase>>>>>>>
  bool selectServiceToFirebaseLoading = false;
  selctedServiceToFirebase(
      {required List selectedServices,
      stripeId,
      buid,
      required businessName,
      businessProfileImage,
      required businessLongitude,
      businessLatitude}) async {
    selectServiceToFirebaseLoading = true;
    notifyListeners();
    log("stripe id ${stripeId}>>>>>>>>>>>>>>");
    log("selectedServices ${selectedServices}>>>>>>>>>>>>>>");
    log("sitePay ${sitePay}>>>>>>>>>>>>>>");
    log("mobilePay ${mobilePay}>>>>>>>>>>>>>>");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('cuid');
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .collection("selectedServices")
        .add({
      'Services': selectedServices,
      'date': today,
      "status": "pending",
      //convert to weekday'
      "time": DateFormat('hh:mm a').format(today),
      "day": DateFormat('EEEE').format(today),
      "month": DateFormat('MMMM').format(today),
      "year": DateFormat('yyyy').format(today),
      "timeSlot": DateFormat('hh:mm a').format(selectedTimeSlots[0]),
      "payonSite": sitePay,
      "mobilePay": mobilePay,
      "totalAmount": totalAmount,
      "stripeid": stripeId ?? 'site pay',
      "businessuid": buid,
      "userPic": user.image,
      "userName": user.name,
      "latitude": user.latitude,
      "longitude": user.longitude,
      "address": user.address ?? "adress not available",
      "custimeruid": user.uid,
      "businessLongitude": businessLongitude,
      "businessLatitude": businessLatitude,
      "businessName": businessName,
      "businessProfileImage": businessProfileImage,
      "completed": false,
      "arrived": false,
    }).then((value) {
      //adding doc id to firebase
      FirebaseFirestore.instance
          .collection("CustomerUsers")
          .doc(uid)
          .collection("selectedServices")
          .doc(value.id)
          .update({"docId": value.id});
    });
    sitePay = false;
    timeSlots.clear();
    selectedTimeSlots.clear();
    selectServiceToFirebaseLoading = false;
    notifyListeners();

    Get.off(
      () => MainUserBottomNavigationBar(),
    );
  }
}
