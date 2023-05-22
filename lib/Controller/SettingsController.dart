import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';

import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';

import 'package:fursa/Models/MobileCodesModel.dart';
import 'package:fursa/Models/NotificationModel.dart';
import 'package:fursa/Models/SettingsModel.dart';
import 'package:fursa/Models/SliderModel.dart';

import 'package:fursa/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

enum SettingsControllerStage { LOADING, ERROR, DONE }

class SettingsController extends ChangeNotifier {
  SettingsControllerStage settingStage;
  MobileCodesModel _mobileCodes;
  MobileCodesModel get mobileCodes => _mobileCodes;
  Future getMobileCodes({context}) async {
    var headers = {'api_password': '123456', 'language': 'ar'};
    http.Response response =
        await http.get(Uri.parse('$domain/mobile-code'), headers: headers);
    final dynamic responseData = (jsonDecode(response.body));
    print('sdasfgghjghjjkhj {${responseData}}');

    if (response.statusCode == 200) {
      _mobileCodes = MobileCodesModel.fromJson(responseData);
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
    // try {
    //   var headers = {
    //     'api_password': '$apiPassword',
    //     'language':
    //         '${Provider.of<LocalizationController>(context, listen: false).locale}'
    //   };
    //   var request =
    //       http.MultipartRequest('GET', Uri.parse('$domain/mobile-code'));

    //   request.headers.addAll(headers);

    //   http.StreamedResponse response = await request.send();

    //   var responseString = await response.stream.bytesToString();
    //   dynamic responseMap = json.decode(responseString);
    //   print(responseMap);
    //   print('dfdsfgffjgjkk;k');
    //   if (response.statusCode == 200 && responseMap['status'] == true) {
    //     _mobileCodes = MobileCodesModel.fromJson(responseMap);
    //   } else {
    //     Alert(
    //       context: context,
    //       type: AlertType.error,
    //       desc: "${responseMap['message']}",
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "${AppLocalizations.of(context).trans('ok')}",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () => Navigator.pop(context),
    //           width: 120,
    //         )
    //       ],
    //     ).show();
    //   }
    // } catch (e) {}
    // notifyListeners();
  }

  splashRequests(context) {
    getMobileCodes(context: context);
  }

  SliderModel _slider;
  SliderModel get slider => _slider;
  Future getHomeScreenSlider({context}) async {
    settingStage = SettingsControllerStage.LOADING;
    var headers = {
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    http.Response response =
        await http.get(Uri.parse('$domain/slider'), headers: headers);
    final dynamic responseData = (jsonDecode(response.body));
    print('sdasfgghjghjjkhj {${responseData}}');

    if (response.statusCode == 200) {
      _slider = SliderModel.fromJson(responseData);
      settingStage = SettingsControllerStage.DONE;
    } else {
      settingStage = SettingsControllerStage.ERROR;
    }
    notifyListeners();
  }

  SettingsModel _settings;
  SettingsModel get settings => _settings;
  getAppSettings({context}) async {
    settingStage = SettingsControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request = http.Request('GET', Uri.parse('${domain}/setting'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    print('response.statusCode${response.statusCode}');
    if (response.statusCode == 200) {
      _settings = SettingsModel.fromJson(responseMap['data']);
      settingStage = SettingsControllerStage.DONE;
    } else {
      settingStage = SettingsControllerStage.ERROR;
    }
  }

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;
  getNotifications({context}) async {
    settingStage = SettingsControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request = http.Request('GET', Uri.parse('$domain/user/notifications'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200) {
      List<dynamic> dynamicNotificationList = responseMap['data'];
      dynamicNotificationList.forEach((element) {
        _notifications.add(NotificationModel.fromJson(element));
      });
      settingStage = SettingsControllerStage.DONE;
    } else {}
    notifyListeners();
  }

  Future contactUs({context, message}) async {
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/user/support'));
    request.fields.addAll({'content': '${message}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseMap);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color1,
        content: Text(
          '${responseMap['message']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          '${responseMap['message']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
  }
}
