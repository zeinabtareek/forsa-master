class MyProductsModel {
  dynamic id;
  dynamic title;
  dynamic image;
  dynamic havingAction;

  MyProductsModel({this.id, this.title, this.image, this.havingAction});

  MyProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    havingAction = json['having_action'];
  }
}
