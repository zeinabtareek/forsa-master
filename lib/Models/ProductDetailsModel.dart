class ProductDetailsModel {
  bool status;
  String errorNumber;
  String message;
  Data data;

  ProductDetailsModel({this.status, this.errorNumber, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  ProductDetails productDetails;
  List<ProductImages> productImages;

  Data({this.productDetails, this.productImages});

  Data.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages.add(new ProductImages.fromJson(v));
      });
    }
  }
}

class ProductDetails {
  dynamic id;
  dynamic title;
  dynamic price;
  dynamic description;
  dynamic image;
  dynamic paidCoupons;
  dynamic couponsCount;
  dynamic avalibale;
  dynamic days;
  dynamic hours;
  dynamic minutes;
  dynamic sub_category_id;
  dynamic main_category_id;
  dynamic main_catgeory_name;
  dynamic sub_catgeory_name;
  dynamic winner_name;
  dynamic winner_image;
  dynamic quantity;
  dynamic coupon_status;
  dynamic cart_row_id;
  dynamic can_add_to_cart;
  ProductDetails(
      {this.id,
      this.title,
      this.price,
      this.sub_category_id,
      this.main_category_id,
      this.main_catgeory_name,
      this.sub_catgeory_name,
      this.description,
      this.image,
      this.winner_name,
      this.quantity,
      this.winner_image,
      this.paidCoupons,
      this.couponsCount,
      this.avalibale,
      this.coupon_status,
      this.days,
      this.cart_row_id,
      this.hours,
      this.can_add_to_cart,
      this.minutes});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    print('sdasdsadsdasdasdas' + '${json['quantity']}');
    id = json['id'];
    title = json['title'];
    price = json['price'];
    can_add_to_cart = json['can_add_to_cart'];
    sub_category_id = json['sub_category_id'];
    main_category_id = json['main_category_id'];
    sub_catgeory_name = json['sub_catgeory_name'];
    main_catgeory_name = json['main_catgeory_name'];
    description = json['description'];
    cart_row_id = json['cart_row_id'];
    image = json['image'];
    winner_name = json['winner_name'];
    winner_image = json['winner_image'];
    quantity = json['quantity'];
    paidCoupons = json['paid_coupons'];
    couponsCount = json['coupons_count'];
    avalibale = json['avalibale'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
  }
}

class ProductImages {
  dynamic id;
  dynamic image;

  ProductImages({this.id, this.image});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
