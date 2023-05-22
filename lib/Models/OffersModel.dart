class OffersModel {
  bool status;
  String errorNumber;
  String message;
  List<Data> data;

  OffersModel({this.status, this.errorNumber, this.message, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  dynamic id;
  dynamic title;
  dynamic price;
  dynamic image;
  dynamic paidCoupons;
  dynamic couponsCount;
  dynamic avalibale;
  dynamic days;
  dynamic hours;
  dynamic minutes;

  Data(
      {this.id,
      this.title,
      this.price,
      this.image,
      this.paidCoupons,
      this.couponsCount,
      this.avalibale,
      this.days,
      this.hours,
      this.minutes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
    paidCoupons = json['paid_coupons'];
    couponsCount = json['coupons_count'];
    avalibale = json['avalibale'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = this.image;
    data['paid_coupons'] = this.paidCoupons;
    data['coupons_count'] = this.couponsCount;
    data['avalibale'] = this.avalibale;
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }
}
