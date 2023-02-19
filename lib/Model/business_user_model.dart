class BusinessUserModel {
  String? image;
  String? coverImage;
  String? serviceCategory;
  String? registrationNumber;
  String? businessName;
  String? gender;
  String? numberOfEmployees;
  String? phoneNumber;
  String? email;
  String? password;
  String? website;
  String? serviceDetails;
  String? uid;
  String? latitude;
  String? longitude;
  String? address;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? serviceCategoryImage;

  // String? serviceName;
  // String? serviceTime;
  // String? servicePrice;
  // String?
  BusinessUserModel({
    this.serviceCategoryImage,
    this.image,
    this.coverImage,
    this.serviceCategory,
    this.registrationNumber,
    this.businessName,
    this.gender,
    this.numberOfEmployees,
    this.uid,
    this.phoneNumber,
    this.email,
    this.password,
    this.serviceDetails,
    this.latitude,
    this.longitude,
    this.website,
    this.address,
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });
  BusinessUserModel.Fromfirebase({firebase}) {
    latitude = firebase["latitude"];
    longitude = firebase["longitude"];
    image = firebase['image'];
    coverImage = firebase['coverImage'];
    serviceCategory = firebase['serviceCategory'];
    registrationNumber = firebase['registrationNumber'];
    businessName = firebase["businessName"];
    gender = firebase["gender"];
    numberOfEmployees = firebase["numberOfEmployees"];
    phoneNumber = firebase["phoneNumber"];
    email = firebase["email"];
    password = firebase["password"];
    website = firebase["website"];
    uid = firebase["uid"];
    serviceDetails = firebase["serviceDetails"];
    address = firebase["adress"];
    state = firebase["state"];
    street = firebase["street"];
    city = firebase["city"];
    postalCode = firebase["postalCode"];
    country = firebase["country"];
    serviceCategoryImage = firebase["serviceCategoryImage"];
  }
  toFirebase() {
    return {
      // "latitude": latitude ?? "",
      // "longitude": longitude ?? "",
      "image": image ?? "",
      "coverImage": coverImage ?? "",
      "serviceCategory": serviceCategory ?? "",
      "registrationNumber": registrationNumber ?? "",
      "businessName": businessName ?? "",
      "gender": gender ?? "",
      "numberOfEmployees": numberOfEmployees,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "website": website,
      "uid": uid,
      "serviceDetails": serviceDetails,
      "serviceCategoryImage": serviceCategoryImage,
      // "address": address
    };
  }
}
