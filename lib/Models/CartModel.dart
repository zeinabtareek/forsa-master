class CartDetailsModel {
  dynamic id;
  dynamic productId;
  dynamic title;
  dynamic quantity;
  dynamic total;
  bool favorite;
  dynamic image;

  CartDetailsModel(
      {this.id,
      this.productId,
      this.title,
      this.quantity,
      this.total,
      this.favorite,
      this.image});

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    quantity = json['quantity'];
    total = json['total'];
    favorite = json['favorite'];
    image = json['image'];
  }
}
