class UserProfileDataModel {
  bool status;
  String errorNumber;
  String message;
  User user;

  UserProfileDataModel(
      {this.status, this.errorNumber, this.message, this.user});

  UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic cityId;
  dynamic address;
  dynamic mobile;
  dynamic deviceToken;
  dynamic image;
  dynamic nationalIdentifierFrontImage;
  dynamic nationalIdentifierBackImage;
  dynamic cityName;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.cityId,
      this.address,
      this.mobile,
      this.deviceToken,
      this.image,
      this.nationalIdentifierFrontImage,
      this.nationalIdentifierBackImage,
      this.cityName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    cityId = json['city_id'];
    address = json['address'];
    mobile = json['mobile'];
    deviceToken = json['device_token'];
    image = json['image'];
    nationalIdentifierFrontImage = json['national_identifier_front_image'];
    nationalIdentifierBackImage = json['national_identifier_back_image'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['device_token'] = this.deviceToken;
    data['image'] = this.image;
    data['national_identifier_front_image'] = this.nationalIdentifierFrontImage;
    data['national_identifier_back_image'] = this.nationalIdentifierBackImage;
    data['city_name'] = this.cityName;
    return data;
  }
}
