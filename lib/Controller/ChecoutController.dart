import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/CartModel.dart';
import 'package:fursa/Models/CheckoutDetailsModel.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/PaymentWebView.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum ChecoutControllerStage { LOADING, DONE, EROR }

class CheckoutController extends ChangeNotifier {
  ChecoutControllerStage cartStage;
  TextEditingController checkoutUserName = TextEditingController();
  TextEditingController checkoutUserEmail = TextEditingController();
  TextEditingController checkoutUserMobile = TextEditingController();
  TextEditingController checkoutUserAddress = TextEditingController();
  TextEditingController checkoutUsercoupoune = TextEditingController();
  var cityId;
  setCityId(city_id) {
    cityId = city_id;
    notifyListeners();
  }

  CheckoutDetailsModel _checkoutDetails;
  CheckoutDetailsModel get checkoutDetails => _checkoutDetails;
  Future checkout({context, productId, quantity}) async {
    var headers = {
      'Authorization': 'Bearer  ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/checkout'));
    request.fields.addAll({
      'name': '${checkoutUserName.text}',
      'email': '${checkoutUserEmail.text}}',
      'mobile': '${checkoutUserMobile.text}',
      'address': '${checkoutUserAddress.text}',
      'city_id': '${cityId}',
      'coupon': '${checkoutUsercoupoune.text}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200) {
      _checkoutDetails = CheckoutDetailsModel.fromJson(responseMap['data']);
    } else {
      print(response.reasonPhrase);
    }

    // var request =
    //     http.MultipartRequest('POST', Uri.parse('$domain/user/add-to-cart'));
    // request.fields.addAll({
    //   'product_id': '$productId',
    //   'quantity': '$quantity',
    // });

    // request.headers.addAll(headers);
    // print(request.fields);
    // http.StreamedResponse response = await request.send();
    // var responseString = await response.stream.bytesToString();
    // dynamic responseMap = json.decode(responseString);
    // print(responseMap);
    // if (response.statusCode == 200 && responseMap['status'] == true) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Color(0xFF195AA4),
    //       content: Text(
    //         '${responseMap['message']}',
    //         style: TextStyle(
    //             fontFamily: 'NotoKufiArabic-Light',
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold),
    //       )));
    // } else {
    //   Alert(
    //     context: context,
    //     type: AlertType.error,
    //     desc: "${responseMap['message']}",
    //     buttons: [
    //       DialogButton(
    //         child: Text(
    //           "${AppLocalizations.of(context).trans('ok')}",
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //         onPressed: () => Navigator.pop(context),
    //         width: 120,
    //       )
    //     ],
    //   ).show();
    // }
  }

  Future getMyFatorah({context, id}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${domain}/user/myfatoorh'));
    request.fields.addAll({'id': '$id'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      Alert(
        context: context,
        type: AlertType.success,
        desc: "${responseMap['message']}",
        style: AlertStyle(descStyle: TextStyle(fontSize: 14)),
        buttons: [
          DialogButton(
            child: Text(
              "${AppLocalizations.of(context).trans('ok')}",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () => fadNavigate(
                context,
                ReservationWebPawment(
                  url: responseMap['link'],
                )),
            width: 120,
          ),
          DialogButton(
            child: Text(
              "${AppLocalizations.of(context).trans('cancel')}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          content: Text(
            '${responseMap['message']}',
            style: TextStyle(
                fontFamily: 'NotoKufiArabic-Light',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )));
    }
  }
}
