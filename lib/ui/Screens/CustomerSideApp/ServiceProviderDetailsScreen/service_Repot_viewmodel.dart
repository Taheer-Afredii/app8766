import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceReportViewModel extends ChangeNotifier {
  TextEditingController reportReasonController = TextEditingController();
  TextEditingController reportIssueDetailsController = TextEditingController();
  bool loading = false;
  sendReport({customerId, businessId}) async {
    loading = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection("ReportsByCustomers").add({
      "ReportBy": customerId,
      "ReportTo": businessId,
      "ReportReason": reportReasonController.text,
      "ReportIssueDetails": reportIssueDetailsController.text,
    });
    Get.snackbar("Success", "Thank you for your feedback");
    Navigator.pop(Get.context!);

    loading = false;

    notifyListeners();
  }
}
