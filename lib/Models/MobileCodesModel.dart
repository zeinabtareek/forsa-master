class MobileCodesModel {
  bool status;
  String errorNumber;
  String message;
  List<MobileCodes> mobileCodes;

  MobileCodesModel(
      {this.status, this.errorNumber, this.message, this.mobileCodes});

  MobileCodesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['mobile_codes'] != null) {
      mobileCodes = <MobileCodes>[];
      json['mobile_codes'].forEach((v) {
        mobileCodes.add(new MobileCodes.fromJson(v));
      });
    }
  }
}

class MobileCodes {
  dynamic id;
  dynamic code;

  MobileCodes({this.id, this.code});

  MobileCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    return data;
  }
}
