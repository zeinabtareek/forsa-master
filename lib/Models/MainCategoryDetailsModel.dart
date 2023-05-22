class MainCategoryDetailsModel {
  Data data;

  MainCategoryDetailsModel({this.data});

  MainCategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<SubCategories> subCategories;
  Products products;

  Data({this.subCategories, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }
}

class SubCategories {
  int id;
  String title;

  SubCategories({this.id, this.title});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Products {
  List<ProductDetails> data;

  Products({
    this.data,
  });

  Products.fromJson(Map<String, dynamic> json) {
    data = <ProductDetails>[];
    json['data'].forEach((v) {
      data.add(new ProductDetails.fromJson(v));
    });
  }
}

class ProductDetails {
  dynamic id;
  dynamic title;
  dynamic price;
  dynamic couponsCount;
  dynamic maxUserCouponsCount;
  dynamic datetime;
  dynamic image;
  dynamic paidCoupons;
  dynamic avalibale;
  dynamic days;
  dynamic hours;
  dynamic minutes;
  dynamic productInCart;
  dynamic canAddToCart;

  ProductDetails(
      {this.id,
      this.title,
      this.price,
      this.couponsCount,
      this.maxUserCouponsCount,
      this.datetime,
      this.image,
      this.paidCoupons,
      this.avalibale,
      this.days,
      this.hours,
      this.minutes,
      this.productInCart,
      this.canAddToCart});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    couponsCount = json['coupons_count'];
    maxUserCouponsCount = json['max_user_coupons_count'];
    datetime = json['datetime'];
    image = json['image'];
    paidCoupons = json['paid_coupons'];
    avalibale = json['avalibale'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    productInCart = json['product_in_cart'];
    canAddToCart = json['can_add_to_cart'];
  }
}
