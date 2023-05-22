class OrderDetailsModel {
  List<Data> data;

  OrderDetailsModel({this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  ProductDetails productDetails;
  // List<Null>? userDetails;

  Data({this.productDetails});

  Data.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }
}

class ProductDetails {
  dynamic id;
  dynamic title;
  dynamic quantity;
  dynamic price;
  dynamic total;
  dynamic createdAt;

  ProductDetails(
      {this.id,
      this.title,
      this.quantity,
      this.price,
      this.total,
      this.createdAt});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    return data;
  }
}
