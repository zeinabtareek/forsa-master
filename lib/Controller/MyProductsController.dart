import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Controller/pageIndexController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/CartModel.dart';
import 'package:fursa/Models/MyProductsModel.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum MyProductsControllerStage { LOADING, DONE, EROR }

class MyProductsController extends ChangeNotifier {
  MyProductsControllerStage myProductsStage;

  List<MyProductsModel> _myProducts = [];
  List<MyProductsModel> get myProducts => _myProducts;
  Future getMyProducts({context}) async {
    myProductsStage = MyProductsControllerStage.LOADING;
    print('${LocaleStorage.token}');
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    http.Response response =
        await http.get(Uri.parse('$domain/user/my-products'), headers: headers);

    final dynamic responseData = (jsonDecode(response.body));
    print(responseData);
    _myProducts.clear();
    print(_myProducts.isEmpty);
    if (response.statusCode == 200 && responseData['status'] == true) {
      if (responseData['data'] != null) {
        List<dynamic> dynamicList = responseData['data'];
        dynamicList.forEach((element) {
          _myProducts.add(MyProductsModel.fromJson(element));
        });
      }
      myProductsStage = MyProductsControllerStage.DONE;
    } else {
      myProductsStage = MyProductsControllerStage.EROR;
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  TextEditingController productTitle = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDiscount = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  var _SelectedMainCatId;
  setSelectedMainCatId(mainCat) {
    _SelectedMainCatId = mainCat;
    notifyListeners();
  }

  var _selectedSubCatId;
  setSelectedSubCatId(subCat) {
    _selectedSubCatId = subCat;
    notifyListeners();
  }

  Future addNewProduct({context}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/save-product'));
    request.headers.addAll(headers);
    request.fields.addAll({
      'title': '${productTitle.text}',
      'main_category_id': '$_SelectedMainCatId',
      'sub_category_id': '$_selectedSubCatId',
      'price': '${productPrice.text}',
      'discount': '${productDiscount.text}',
      'description': '${productdescription.text}'
    });
    var images =
        Provider.of<ImagePickerController>(context, listen: false).imagefiles;
    if (Provider.of<ImagePickerController>(context, listen: false)
        .imagefiles
        .isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'images[$i]', '${images[i].path}'));
      }
    }

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      Alert(
        context: context,
        type: AlertType.success,
        desc: "تم اضافة المنتج بنجاح",
        buttons: [
          DialogButton(
            child: Text(
              "${AppLocalizations.of(context).trans('ok')}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              Provider.of<PageIndexController>(context, listen: false)
                  .changeIndexFunction(0);
              fadNavigate(context, NavigationHomeScreen());
            },
            width: 120,
          )
        ],
      ).show();
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
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  Future deleteProduct({context, productId}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('$domain/user/delete-product/${productId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200) {
      getMyProducts(context: context);
    } else {}
  }
}
