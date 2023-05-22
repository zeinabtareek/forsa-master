import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/OffersModel.dart';
import 'package:fursa/Models/OrderDetailsModel.dart';
import 'package:fursa/Models/OrderModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum OrderControllerStage { LOADING, ERROR, DONE }

class OrderController extends ChangeNotifier {
  OrderControllerStage ordersStage;
  List<OrderItemModel> _orders = [];
  List<OrderItemModel> get orders => _orders;
  Future getOrders({context}) async {
    ordersStage = OrderControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer  ${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response =
        await http.get(Uri.parse('$domain/user/orders'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);
    if (response.statusCode == 200) {
      if (responseData['data'] != null) {
        List<dynamic> dynamicList = responseData['data'];
        dynamicList.forEach((element) {
          _orders.add(OrderItemModel.fromJson(element));
        });
      }
      ordersStage = OrderControllerStage.DONE;
    } else {
      ordersStage = OrderControllerStage.ERROR;
    }
    notifyListeners();
  }

  OrderDetailsModel _orderDetails;
  OrderDetailsModel get orderDetails => _orderDetails;
  Future getOrderDetails({context, orderId}) async {
    ordersStage = OrderControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer  ${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response = await http
        .get(Uri.parse('$domain/user/orders/$orderId'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);
    if (response.statusCode == 200) {
      _orderDetails = OrderDetailsModel.fromJson(responseData);
      ordersStage = OrderControllerStage.DONE;
    } else {
      ordersStage = OrderControllerStage.ERROR;
    }
    notifyListeners();
  }
}
