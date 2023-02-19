class CustomerUserModel {
  String? image;
  String? name;
  String? email;
  String? gender;
  String? phoneNumber;
  String? password;
  String? uid;
  String? address;
  String? latitude;
  String? longitude;
  String? street;
  String? city;
  String? country;

  CustomerUserModel({
    this.name,
    this.image,
    this.email,
    this.gender,
    this.phoneNumber,
    this.address,
    this.password,
    this.uid,
    this.latitude,
    this.longitude,
    this.country,
    this.street,
    this.city,
  });

  CustomerUserModel.fromFirebase({firebase}) {
    image = firebase["image"] ?? "";
    name = firebase['name'] ?? '';
    email = firebase["email"] ?? "";
    gender = firebase["gender"] ?? "";
    phoneNumber = firebase["phoneNumber"] ?? "";
    password = firebase["password"] ?? "";
    uid = firebase["uid"] ?? "";
    address = firebase["address"] ?? "";
    latitude = firebase["latitude"] ?? "";
    longitude = firebase["longitude"] ?? "";
    city = firebase["city"] ?? "";
    street = firebase["street"] ?? "";
    country = firebase["country"] ?? "";
  }
  toFirebase() {
    return {
      "image": image ?? "",
      "name": name ?? '',
      "email": email ?? "",
      "gender": gender ?? "",
      "phoneNumber": phoneNumber ?? "",
      "password": password ?? "",
      "uid": uid ?? "",
      "address": address ?? "",
    };
  }
}
