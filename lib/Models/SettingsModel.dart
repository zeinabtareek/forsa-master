class SettingsModel {
  dynamic email;
  dynamic mobile;
  dynamic websiteName;
  dynamic facebookLink;
  dynamic instgramLink;
  dynamic twitterLink;
  dynamic address;
  dynamic whatsapp;
  dynamic androidLink;
  dynamic iosLink;
  dynamic policy;
  List<Cities> cities;

  SettingsModel(
      {this.email,
      this.mobile,
      this.websiteName,
      this.facebookLink,
      this.instgramLink,
      this.twitterLink,
      this.address,
      this.whatsapp,
      this.androidLink,
      this.iosLink,
      this.policy,
      this.cities});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    websiteName = json['website_name'];
    facebookLink = json['facebook_link'];
    instgramLink = json['instgram_link'];
    twitterLink = json['twitter_link'];
    address = json['address'];
    whatsapp = json['whatsapp'];
    androidLink = json['android_link'];
    iosLink = json['ios_link'];
    policy = json['policy'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
  }
}

class Cities {
  dynamic id;
  dynamic name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
