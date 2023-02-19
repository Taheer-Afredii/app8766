import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserReportViewModel extends ChangeNotifier {
  TextEditingController reportReasonController = TextEditingController();
  TextEditingController reportIssueDetailsController = TextEditingController();
  bool loading = false;
  sendReport({customerId, businessId}) async {
    loading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("ReportsByServiceProvider")
        .add({
      "ReportBy": businessId,
      "ReportTo": customerId,
      "ReportReason": reportReasonController.text,
      "ReportIssueDetails": reportIssueDetailsController.text,
    });
    Get.snackbar("Success", "Thank you for your feedback");
    Navigator.pop(Get.context!);

    loading = false;

    notifyListeners();
  }
}
