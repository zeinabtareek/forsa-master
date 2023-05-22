import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/MainCategoryDetailsModel.dart';
import 'package:fursa/Models/MainCategoryModel.dart';
import 'package:fursa/Models/singleProductModel.dart';
import 'package:fursa/main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

enum CategoryControllerStage { LOADING, DONE, ERROR }

class CategoryController extends ChangeNotifier {
  CategoryControllerStage categoryStage;
  int pageNumber = 1;
  int get nextPage => pageNumber;
  MainCategoryModel _someMainCatList;
  MainCategoryModel get someMainCatList => _someMainCatList;
  Future getSomeMainCategory({context}) async {
    categoryStage = CategoryControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}',
      'Authorization': 'Bearer  ${LocaleStorage.token}'
    };
    var request = http.Request('GET', Uri.parse('$domain/main-categories'));

     request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('response.statusCode ${response.statusCode}');
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      _someMainCatList = MainCategoryModel.fromJson(responseMap);
      categoryStage = CategoryControllerStage.DONE;
    } else {
      categoryStage = CategoryControllerStage.ERROR;
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
    notifyListeners();
  }

  MainCategoryModel _mainCatList;
  MainCategoryModel get mainCatList => _mainCatList;
  Future getMainCat({context}) async {
    categoryStage = CategoryControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}',
      'Authorization': 'Bearer ${LocaleStorage.token}'
    };
    var request = http.Request('GET', Uri.parse('$domain/all-main-categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print('responseMap$responseMap');
    if (response.statusCode == 200) {
      _mainCatList = MainCategoryModel.fromJson(responseMap);
      categoryStage = CategoryControllerStage.DONE;
    } else {
      categoryStage = CategoryControllerStage.ERROR;
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
    notifyListeners();
  }

  CategoryControllerStage categoryDetailsSatge;
  var token = LocaleStorage.token;
  var _mainCategoryId;
  setMainCatId(mainCatId) {
    _mainCategoryId = mainCatId;
    notifyListeners();
  }

  MainCategoryDetailsModel _mainCategoryDetails;
  MainCategoryDetailsModel get mainCategoryDetails => _mainCategoryDetails;
  Future getMainCategoryDetails({context, main_CategoryId}) async {
    categoryDetailsSatge = CategoryControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}',
      'guest_token': '${LocaleStorage.token}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$domain/main-categories/${main_CategoryId != null ? main_CategoryId : _mainCategoryId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print("Main Cat details : ${responseMap}");
    _mainCategoryDetails = MainCategoryDetailsModel();
    if (response.statusCode == 200 && responseMap['status'] == true) {
      if (responseMap['data'] != null) {
        _mainCategoryDetails = MainCategoryDetailsModel.fromJson(responseMap);
      }
      categoryDetailsSatge = CategoryControllerStage.DONE;
    } else {
      categoryDetailsSatge = CategoryControllerStage.ERROR;
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
    notifyListeners();
  }

  CategoryControllerStage updateProductsStage;
  Future updateMainCategoryDetails({context}) async {
    updateProductsStage = CategoryControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}',
      ' guest_token': '${LocaleStorage.token}'
    };
    var request = http.Request(
        'GET', Uri.parse('$domain/main-categories/$_mainCategoryId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print("Main Cat details : ${responseMap}");
    _mainCategoryDetails = MainCategoryDetailsModel();
    if (response.statusCode == 200) {
      _mainCategoryDetails = MainCategoryDetailsModel.fromJson(responseMap);
      updateProductsStage = CategoryControllerStage.DONE;
    } else {
      updateProductsStage = CategoryControllerStage.ERROR;
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
    notifyListeners();
  }

  var _subCategoryId;
  get subCategoryId => _subCategoryId;
  setSubcategoryId(subCatId) {
    _subCategoryId = subCatId;
    print(_subCategoryId);
    notifyListeners();
  }

  resetSubCatId() {
    _subCategoryId = null;
    notifyListeners();
  }

  CategoryControllerStage subCategoryDetailsSatge;
  List<SingleProductModel> _subCatProductsList = [];
  List<SingleProductModel> get subCatProductsList => _subCatProductsList;
  setSubCatProductsList(subCatList) {
    _subCatProductsList = subCatList;
  }

  List<SingleProductModel> newsubCatProductsList = [];
  getSubCategoryProducts({context, currentPageNumber = 1}) async {
    if (currentPageNumber == 1) {
      updateProductsStage = CategoryControllerStage.LOADING;
    }
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}',
      'guest_token': '${LocaleStorage.token}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$domain/sub-categories/$_subCategoryId?page=$currentPageNumber'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);

    if (currentPageNumber == 1) {
      _subCatProductsList.clear();
    }
    pageNumber = currentPageNumber;
    if (response.statusCode == 200 && responseMap['status'] == true) {
      List<dynamic> dynamicProdsList = responseMap['data']['products']['data'];
      dynamicProdsList.forEach((element) {
        newsubCatProductsList.add(SingleProductModel.fromJson(element));
      });
      setSubCatProductsList(newsubCatProductsList);
      pageNumber++;

      updateProductsStage = CategoryControllerStage.DONE;
    } else {
      print(_subCatProductsList.length);

      updateProductsStage = CategoryControllerStage.ERROR;
    }
    // } catch (e) {
    //   print('$e');
    // }
    notifyListeners();
  }
}
