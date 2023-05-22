import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/UserDataModel.dart';
import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserDataController extends ChangeNotifier {
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateFirstNameController = TextEditingController();
  TextEditingController updateMobileController = TextEditingController();
  TextEditingController updateLastNameController = TextEditingController();
  TextEditingController updatePasswordController = TextEditingController();
  TextEditingController updateaddressController = TextEditingController();
  var cityId;
  getProfileIntialValues() {
    updateEmailController.text = _userProfileDetails.user.email;
    updateFirstNameController.text = _userProfileDetails.user.firstName;
    updateMobileController.text = _userProfileDetails.user.mobile;
    updateLastNameController.text = _userProfileDetails.user.lastName;
    updateaddressController.text = _userProfileDetails.user.address;
    cityId = _userProfileDetails.user.cityId;
    print(LocaleStorage.userEmail);
    print(LocaleStorage.userName);
    print(LocaleStorage.userPhone);
  }

  setCityIdForUpdate(city) {
    cityId = city;
  }

  Future updateProfile({context}) async {
    try {
      var headers = {
        'Authorization': 'Bearer   ${LocaleStorage.token}',
        'api_password': '$apiPassword',
        'language':
            '${Provider.of<LocalizationController>(context, listen: false).locale}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('$domain/update-profile'));
      request.fields.addAll({
        'first_name': '${updateFirstNameController.text}',
        'last_name': '${updateLastNameController.text}',
        'email': '${updateEmailController.text}',
        'mobile': '${updateMobileController.text}',
        'password': '${updatePasswordController.text}',
        'address': '${updateaddressController.text}',
        "city_id": '$cityId',
        // "image": 'image',
        // "national_identifier_back_image": 'national_identifier_back_image',
        // "national_identifier_front_image": 'national_identifier_front_image',
      });
      final imagePickerController =
          Provider.of<ImagePickerController>(context, listen: false);
      if (imagePickerController.personalImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image', '${imagePickerController.personalImageFile.path}'));
      }
      if (imagePickerController.frontIDImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'national_identifier_front_image',
            '${imagePickerController.frontIDImageFile.path}'));
      }
      if (imagePickerController.backIDImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'national_identifier_back_image',
            '${imagePickerController.backIDImageFile.path}'));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      dynamic responseMap = json.decode(responseString);
      print(responseMap);
      if (response.statusCode == 200 && responseMap['status'] == true) {
        getUserData(context: context);
        Alert(
          context: context,
          type: AlertType.success,
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
    } catch (e) {}
  }

  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  Future updatePassword({context}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/update-password'));
    request.fields.addAll({
      'password': '${password.text}',
      'password_confirmation': '${passwordConfirmation.text}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200 && responseMap['status'] == true) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  UserProfileDataModel _userProfileDetails;
  UserProfileDataModel get userProfileDetails => _userProfileDetails;
  Future getUserData({context}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };

    http.Response response =
        await http.get(Uri.parse('$domain/user/get-user'), headers: headers);
    final dynamic responseData = (jsonDecode(response.body));
    print(responseData);
    if (response.statusCode == 200) {
      _userProfileDetails = UserProfileDataModel.fromJson(responseData);
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  bool checkIfUserAuthed(function) {
    if (LocaleStorage.token != null) {
      function;
      return true;
    } else {
      return false;
    }
  }
}
