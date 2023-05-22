class WinnersModel {
  List<Data> data;

  WinnersModel({this.data});

  WinnersModel.fromJson(Map<String, dynamic> json) {
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
  dynamic productId;
  dynamic productName;
  dynamic productImage;
  dynamic userId;
  dynamic userName;
  dynamic date;

  Data(
      {this.id,
      this.productId,
      this.productName,
      this.productImage,
      this.userId,
      this.userName,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    userId = json['user_id'];
    userName = json['user_name'];
    date = json['date'];
  }
}
