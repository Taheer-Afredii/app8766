import 'dart:developer';
import 'dart:io';

import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/GetBusinessLocationScreen/GetBusinessLocationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadBusinessFileViewModel extends ChangeNotifier {
  double progress = 0.0;
  PlatformFile? file;
  FilePickerResult? result;
  List<String> pdfUrlList = [];
  List<double> progressValue = [];
  bool isUploading = false;

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', "txt"]);
    if (result == null) return;
    file = result!.files.first;
    progressValue = List.filled(result!.files.length, 0.0);

    notifyListeners();
    print("$file");

    print("$file");
  }

  docUplaoding() async {
    isUploading = true;
    notifyListeners();
    await uploadFileToFirebase();
    await docToFirebase();
    isUploading = false;
    notifyListeners();
  }

  uploadFileToFirebase() async {
    pdfUrlList.clear();
    if (result != null) {
      for (var i = 0; i < result!.files.length; i++) {
        UploadTask task = FirebaseStorage.instance
            .ref()
            .child(
                "BusinessDOC/${DateTime.now().millisecondsSinceEpoch.toString()}")
            .putFile(File(result!.files[i].path!));
        task.snapshotEvents.listen((event) {
          progressValue[i] = ((event.bytesTransferred.toDouble() /
                          event.totalBytes.toDouble()) *
                      100)
                  .roundToDouble() /
              100;
          notifyListeners();
          log("progress $progress");
        });
        String url = await (await task).ref.getDownloadURL();
        pdfUrlList.add(url);
        progress == 1.0 ? log("reset varible") : log("keep");
        log("url $pdfUrlList");

        notifyListeners();
      }
      log("file uploadd succes");
    }
  }

//add data to firebase
  docToFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("buid");
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(uid)
        .collection("documents")
        .add({
      "documentList": pdfUrlList,
    });

    log("isUplaoding ${isUploading}");

    notifyListeners();
    await Get.to(GetBusinessLocationScreen());
  }
}

class DocumentModel {
  String docName;
  String fileSizeMbs;
  String fileType;

  DocumentModel({
    required this.docName,
    required this.fileSizeMbs,
    required this.fileType,
  });
}

List<DocumentModel> documentsList = [
  DocumentModel(docName: 'Document 1', fileSizeMbs: '20', fileType: 'PDF'),
  DocumentModel(docName: 'Document 2', fileSizeMbs: '21', fileType: 'PDF'),
  DocumentModel(docName: 'Document 3', fileSizeMbs: '25', fileType: 'PDF'),
  DocumentModel(docName: 'Document 4', fileSizeMbs: '37', fileType: 'PDF'),
  DocumentModel(docName: 'Document 5', fileSizeMbs: '3', fileType: 'PDF'),
  DocumentModel(docName: 'Document 6', fileSizeMbs: '33', fileType: 'PDF'),
  DocumentModel(docName: 'Document 7', fileSizeMbs: '9', fileType: 'PDF'),
  DocumentModel(docName: 'Document 8', fileSizeMbs: '42', fileType: 'PDF'),
  DocumentModel(docName: 'Document 9', fileSizeMbs: '47', fileType: 'PDF'),
];
