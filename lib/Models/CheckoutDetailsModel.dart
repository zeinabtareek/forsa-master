class CheckoutDetailsModel {
  dynamic id;
  dynamic total;
  List<Details> details;

  CheckoutDetailsModel({this.id, this.total, this.details});

  CheckoutDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }
}

class Details {
  dynamic id;
  dynamic title;
  dynamic quantity;
  dynamic price;
  dynamic total;
  dynamic image;

  Details(
      {this.id, this.title, this.quantity, this.price, this.total, this.image});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    image = json['image'];
  }
}
