import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/OffersModel.dart';
import 'package:fursa/Models/OrderDetailsModel.dart';
import 'package:fursa/Models/OrderModel.dart';
import 'package:fursa/Models/WinnersModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum WinnersControllerStage { LOADING, ERROR, DONE }

class WinnersController extends ChangeNotifier {
  WinnersControllerStage winnersStage;
  WinnersModel _winners;
  WinnersModel get winners => _winners;
  Future getWinners({context}) async {
    winnersStage = WinnersControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer  ${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response =
        await http.get(Uri.parse('$domain/winners'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);
    if (response.statusCode == 200) {
      _winners = WinnersModel.fromJson(responseData);
      winnersStage = WinnersControllerStage.DONE;
    } else {
      winnersStage = WinnersControllerStage.ERROR;
    }
    notifyListeners();
  }

  OrderDetailsModel _orderDetails;
  OrderDetailsModel get orderDetails => _orderDetails;
  Future getOrderDetails({context, orderId}) async {
    winnersStage = WinnersControllerStage.LOADING;
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
      winnersStage = WinnersControllerStage.DONE;
    } else {
      winnersStage = WinnersControllerStage.ERROR;
    }
    notifyListeners();
  }
}
