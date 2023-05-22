import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/LatestProductsDetails.dart';
import 'package:fursa/Models/ProductDetailsModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum ProductsControllerStage { LOADING, DONE, EROR }

class ProductsController extends ChangeNotifier {
  ProductsControllerStage productStage;

  LatestProductsModel _latestProducts;
  LatestProductsModel get latestProducts => _latestProducts;
  Future getLatestProductList({context}) async {
    productStage = ProductsControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('GET', Uri.parse('$domain/latest-products'));
    http.Response response =
        await http.get(Uri.parse('$domain/latest-products'), headers: headers);
    final dynamic responseData = (jsonDecode(response.body));
    request.headers.addAll(headers);

    print(responseData);

    if (response.statusCode == 200) {
      productStage = ProductsControllerStage.LOADING;
      _latestProducts = LatestProductsModel.fromJson(responseData);
      productStage = ProductsControllerStage.DONE;
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseData['message']}",
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

  ProductDetailsModel _productDetails;

  ProductDetailsModel get productDetails => _productDetails;
  Future getProductDetails({context, productId}) async {
    productStage = ProductsControllerStage.LOADING;
    var headers = {
      'guest_token': '${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response = await http
        .get(Uri.parse('$domain/view-product/$productId'), headers: headers);
    print('$domain/view-product/$productId');
    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);

    if (response.statusCode == 200) {
      _productDetails = ProductDetailsModel.fromJson(responseData);

      productStage = ProductsControllerStage.DONE;
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseData['message']}",
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

  Future getUpdatedProductDetails({context, productId}) async {
    var headers = {
      'guest_token': '${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response = await http
        .get(Uri.parse('$domain/view-product/$productId'), headers: headers);
    print('$domain/view-product/$productId');
    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);

    if (response.statusCode == 200) {
      _productDetails = ProductDetailsModel.fromJson(responseData);
      productStage = ProductsControllerStage.DONE;
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseData['message']}",
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

  TextEditingController updateProductTitle = TextEditingController();
  TextEditingController updateProductprice = TextEditingController();
  TextEditingController updateProductDiscount = TextEditingController();
  TextEditingController updateProductDescription = TextEditingController();
  var _categoryName;
  get caregoryName => _categoryName;
  var _subCategoryName;
  get subCategoryName => _subCategoryName;
  var categoryId;
  var subCategoryId;
  setMainCatID(mainCat) {
    categoryId = mainCat;
    notifyListeners();
  }

  setSubcat(subCat) {
    subCategoryId = subCat;
    notifyListeners();
  }

  Future updateProduct({context, productId}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/update-product'));
    request.fields.addAll({
      'product_id': '$productId',
      'title': '${updateProductTitle.text}',
      'main_category_id': '$categoryId',
      'sub_category_id': '$subCategoryId',
      'price': '${updateProductprice.text}',
      'discount': '${updateProductDiscount.text}',
      'description': '${updateProductDescription.text}'
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
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(request.headers);
    print(responseMap);
    print(request.fields);
    if (response.statusCode == 200) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: AppLocalizations.of(context).locale.languageCode == 'en'
              ? "Updated successfully"
              : "تم التحديث بنجاح",
        ),
        displayDuration: Duration(milliseconds: 550),
      );

      Provider.of<MyProductsController>(context, listen: false)
          .getMyProducts(context: context);
    } else {}
  }

  ProductDetailsModel _myProductDetails;

  ProductDetailsModel get myProductDetails => _myProductDetails;
  viewMyProducts({context, productId}) async {
    productStage = ProductsControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '${apiPassword}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response = await http.get(
        Uri.parse('$domain/user/view-my-product/$productId'),
        headers: headers);
    print('$domain/user/view-my-product/$productId');
    final dynamic responseData = (jsonDecode(response.body));

    print(responseData);

    if (response.statusCode == 200) {
      _myProductDetails = ProductDetailsModel.fromJson(responseData);
      getInialValues(context: context);
      productStage = ProductsControllerStage.DONE;
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseData['message']}",
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

  getInialValues({context}) {
    Provider.of<CategoryController>(context, listen: false)
        .getMainCategoryDetails(
            context: context,
            main_CategoryId:
                _myProductDetails.data.productDetails.main_category_id);
    updateProductDescription.text =
        _myProductDetails.data.productDetails.description;
    updateProductprice.text =
        _myProductDetails.data.productDetails.price.toString();
    updateProductDiscount.text = '0';

    subCategoryId = _myProductDetails.data.productDetails.sub_category_id;
    categoryId = _myProductDetails.data.productDetails.main_category_id;

    updateProductTitle.text = _myProductDetails.data.productDetails.title;
    _categoryName = _myProductDetails.data.productDetails.main_catgeory_name;
    _subCategoryName = _myProductDetails.data.productDetails.sub_catgeory_name;
  }
}
