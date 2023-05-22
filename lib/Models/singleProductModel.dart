class SingleProductModel {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic image;
  dynamic days;
  dynamic hours;
  dynamic minutes;
  dynamic avalibale;
  dynamic paid_coupons;
  dynamic coupons_count;
  dynamic price;
  dynamic product_in_cart;
  dynamic can_add_to_cart;
  SingleProductModel(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.can_add_to_cart,
      this.product_in_cart});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    avalibale = json['avalibale'];
    can_add_to_cart = json['can_add_to_cart'];
    product_in_cart = json['product_in_cart'];
    paid_coupons = json['paid_coupons'];
    coupons_count = json['coupons_count'];
    price = json['price'];
  }
}
