class OrderItemModel {
  dynamic id;
  dynamic operationDate;
  dynamic serialNumber;
  dynamic countItems;
  dynamic total;
  dynamic createdAt;

  OrderItemModel(
      {this.id,
      this.operationDate,
      this.serialNumber,
      this.countItems,
      this.total,
      this.createdAt});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operationDate = json['operation_date'];
    serialNumber = json['serial_number'];
    countItems = json['count_items'];
    total = json['total'];
    createdAt = json['created_at'];
  }
}
