class NotificationModel {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic seen;
  dynamic type;
  dynamic itemId;

  NotificationModel(
      {this.id,
      this.title,
      this.description,
      this.seen,
      this.type,
      this.itemId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    seen = json['seen'];
    type = json['type'];
    itemId = json['item_id'];
  }
}
