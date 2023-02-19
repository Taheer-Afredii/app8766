class BusinessUserAddserviceModel {
  BusinessUserAddserviceModel({
    this.serviceName,
    this.servicePrice,
    this.serviceTime,
    this.serviceDescount,
    this.getPaidAfter,
    this.gePaidInAdvance,
    this.uid,
    this.docid,
  });

  String? serviceName;
  String? servicePrice;
  String? serviceDescount;
  String? serviceTime;
  bool? getPaidAfter;
  bool? gePaidInAdvance;
  String? uid;
  String? docid;
  String? date;
  String? day;
  String? month;
  String? year;
  BusinessUserAddserviceModel.fromFirebase({firebase}) {
    serviceName = firebase['serviceName'] ?? '';
    servicePrice = firebase['servicePrice'] ?? '';
    serviceDescount = firebase['serviceDescount'] ?? '';
    serviceTime = firebase['serviceTime'] ?? '';
    getPaidAfter = firebase['getPaidAfter'] ?? false;
    gePaidInAdvance = firebase['gePaidInAdvance'] ?? false;
    uid = firebase['uid'] ?? '';
    docid = firebase['docId'] ?? '';
    date = firebase['date'] ?? '';
    day = firebase['day'] ?? '';
    month = firebase['month'] ?? '';
    year = firebase['year'] ?? '';
  }

  toFirebase() {
    return {
      "serviceName": serviceName ?? '',
      "servicePrice": servicePrice ?? '',
      "serviceDescount": serviceDescount ?? '',
      "serviceTime": serviceTime ?? '',
      "getPaidAfter": getPaidAfter ?? false,
      "gePaidInAdvance": gePaidInAdvance ?? false,
      "uid": uid ?? '',
      "docId": docid ?? '',
      "date": DateTime.now().toString(),
      "day": DateTime.now().day.toString(),
      "month": DateTime.now().month.toString(),
      "year": DateTime.now().year.toString(),
    };
  }
}
