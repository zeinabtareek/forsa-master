class MainCategoryModel {
  bool status;
  dynamic errorNumber;
  dynamic message;
  List<MainCategoryItemModel> mainCategoryList;

  MainCategoryModel(
      {this.status, this.errorNumber, this.message, this.mainCategoryList});

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['data'] != null) {
      mainCategoryList = <MainCategoryItemModel>[];
      json['data'].forEach((v) {
        mainCategoryList.add(new MainCategoryItemModel.fromJson(v));
      });
    }
  }
}

class MainCategoryItemModel {
  dynamic id;
  dynamic title;
  dynamic image;

  MainCategoryItemModel({this.id, this.title, this.image});

  MainCategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
