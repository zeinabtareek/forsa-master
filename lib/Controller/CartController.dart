import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/CartModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum CartControllerStage { LOADING, DONE, EROR }

class CartController extends ChangeNotifier {
  CartControllerStage cartStage;
  Future addToCart({context, productId, quantity}) async {
    var headers = {
      'Authorization': 'Bearer  ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/add-to-cart'));
    request.fields.addAll({
      'product_id': '$productId',
      'quantity': '$quantity',
    });

    request.headers.addAll(headers);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "${responseMap['message']}",
        ),
        displayDuration: Duration(milliseconds: 550),
      );
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseMap['message']}",
        buttons: [
          DialogButton(
            child: Text(
              "${AppLocalizations.of(context).trans('ok')}",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  List<CartDetailsModel> _cartList = [];
  List<CartDetailsModel> get cartList => _cartList;
  Future getCartList({context}) async {
    cartStage = CartControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    http.Response response =
        await http.get(Uri.parse('$domain/user/cart'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));
    print(responseData);
    _cartList.clear();
    if (response.statusCode == 200 && responseData['status'] == true) {
      List<dynamic> dynamicCartList = responseData['data'];
      if (responseData['data'] != null) {
        dynamicCartList.forEach((element) {
          _cartList.add(CartDetailsModel.fromJson(element));
        });
      }

      cartStage = CartControllerStage.DONE;
    } else {
      cartStage = CartControllerStage.EROR;
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  Future updateCartItem({context, productId, keyOperationValue}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    print('${LocaleStorage.token}');
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/update-cart'));
    request.headers.addAll(headers);
    request.fields.addAll({
      'row_id': '${productId}',
      'key_operation_value': '${keyOperationValue}'
    });
    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();

    dynamic responseMap = json.decode(responseString);
    print(request.fields);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "${responseMap['message']}",
        ),
        displayDuration: Duration(milliseconds: 550),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20.0) + EdgeInsets.only(bottom: 0.0),
          content: Text('${responseMap['message']}')));
    }
  }

  Future getUpdatedCartList({context}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    http.Response response =
        await http.get(Uri.parse('$domain/user/cart'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));
    print(responseData);
    if (response.statusCode == 200 && responseData['status'] == true) {
      if (responseData['data'] != null) {
        List<dynamic> dynamicCartList = responseData['data'];
        dynamicCartList.forEach((element) {
          _cartList.add(CartDetailsModel.fromJson(responseData));
        });
      }
    } else {
      cartStage = CartControllerStage.EROR;
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  Future removeFromCart({context, cartId, index, scaffoldkey}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response = await http.get(
        Uri.parse('$domain/user/remove-from-cart/$cartId'),
        headers: headers);

    final dynamic responseData = (jsonDecode(response.body));
    cartList.removeAt(index);
    print(responseData);
    if (response.statusCode == 200) {
      // scaffoldkey.currentState.showSnackBar(SnackBar(
      //     backgroundColor: color1,
      //     behavior: SnackBarBehavior.fixed,
      //     content: Text(
      //       '${responseData['message']}',
      //       style: TextStyle(fontFamily: 'NotoKufiArabic-Light'),
      //     )));
    } else {}
  }
}
