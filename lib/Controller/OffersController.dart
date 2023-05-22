import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Models/OffersModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum offersControllerStage { LOADING, ERROR, DONE }

class OffersController extends ChangeNotifier {
  offersControllerStage offersStage;
  OffersModel _offers;
  OffersModel get offers => _offers;
  Future getOffers({context}) async {
    offersStage = offersControllerStage.LOADING;
    var headers = {
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response =
        await http.get(Uri.parse('$domain/offers'), headers: headers);
    print( 'response.statusCode ${response.statusCode}');
    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);
    if (response.statusCode == 200) {
      _offers = OffersModel.fromJson(responseData);
      offersStage = offersControllerStage.DONE;
    } else {
      offersStage = offersControllerStage.ERROR;
    }
    notifyListeners();
  }
}
