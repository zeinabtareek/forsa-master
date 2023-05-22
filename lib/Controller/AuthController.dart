import 'dart:convert';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Core/Services/NotificationsServices/firebase_messaging_service.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/HelperWidgets.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/main.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum AuthControllerStage { LOADING, DONE, ERROR }

class AuthController extends ChangeNotifier {
  AuthControllerStage authStage;
  Future getUserData() async {
    LocaleStorage.is_loggedIn =
        await LocaleStorage.getUserLoggedInSharedPreferences();
    LocaleStorage.userId = await LocaleStorage.getUserIdInSharedPreferences();
    LocaleStorage.userName =
        await LocaleStorage.getUsernameInSharedPreferences();
    LocaleStorage.userPassWord =
        await LocaleStorage.getUserPasswordInSharedPreferences();
    LocaleStorage.userEmail =
        await LocaleStorage.getUserEmailInSharedPreferences();
    LocaleStorage.userPhone =
        await LocaleStorage.getUserPhoneInSharedPreferences();
    LocaleStorage.token = await LocaleStorage.getUserTokenInSharedPreferences();
    LocaleStorage.comeFrom =
        await LocaleStorage.getUserComeFromInSharedPreferences();
    LocaleStorage.status =
        await LocaleStorage.getUserTokenInSharedPreferences();
    LocaleStorage.userAvatar =
        await LocaleStorage.getUserAvatarInSharedPreferences();
  }

  ///////////////////////////////////// Login /////////////////////////////
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future login({context}) async {
    this.authStage = AuthControllerStage.LOADING;
    final locale =
        Provider.of<LocalizationController>(context, listen: false).locale;
    String url = '$domain/login';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'language': '$locale'
    };
    var formData = FormData.fromMap({
      'email': '${emailController.text}',
      'password': "${passwordController.text}",
      'fcm_token': '${FirebaseMessagingService.instance.fcmToken}',
    });

    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              responseType: ResponseType.bytes,
              validateStatus: (status) => true,
              headers: headers));
      var responseJsonn = response.data;
      var convertedResponse = utf8.decode(responseJsonn);
      var responseJson = json.decode(convertedResponse);
    print('response.statusCode ${response.statusCode}');
      if (response.statusCode == 200 && responseJson["status"] == true) {

        LocaleStorage.saveUserLoggedInSharedPreferences(true);
        LocaleStorage.saveUserIdInSharedPreferences(
            responseJson["user"]["id"].toString());

        LocaleStorage.saveUsernameInSharedPreferences(
            responseJson["user"]["name"]);
        LocaleStorage.saveUserEmailInSharedPreferences(
            responseJson["user"]["email"]);
        LocaleStorage.saveStatusInSharedPreferences(
            responseJson["user"]["status"].toString());
        LocaleStorage.saveUserPhoneInSharedPreferences(
            responseJson["user"]["mobile"]);

        LocaleStorage.saveUserTokenInSharedPreferences(
            responseJson["user"]["api_token"]);
        getUserData();
        Provider.of<SettingsController>(context, listen: false)
            .getAppSettings(context: context);
        this.authStage = AuthControllerStage.DONE;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationHomeScreen()));





      } else {
        this.authStage = AuthControllerStage.ERROR;
        var error = responseJson['message'];
        Alert(
          context: context,
          type: AlertType.error,
          desc: "${responseJson['message']}",
          style: AlertStyle(descStyle: TextStyle(fontSize: 14)),
          buttons: [
            DialogButton(
              child: Text(
                "${AppLocalizations.of(context).trans('ok')}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    } catch (e) {
      this.authStage = AuthControllerStage.ERROR;
      print(e);
      throw e;
    }
    notifyListeners();
  }

  void loginSubmit({@required context, @required scaffoldkey}) async {
    this.authStage = AuthControllerStage.LOADING;
    if (passwordController.text != null &&
        passwordController.text.isNotEmpty &&
        emailController.text != null &&
        emailController.text.isNotEmpty) {
      login(
        context: context,
      ).then((val) {
        this.authStage = AuthControllerStage.DONE;
      });
    } else {
      this.authStage = AuthControllerStage.ERROR;
      showSnack(
        color: Colors.red.withOpacity(0.7),
        isFloating: true,
        context: context,
        fullHeight: 30.0,
        scaffoldKey: scaffoldkey,
        marginBottom: 20.0,
        msg: AppLocalizations.of(context).locale.languageCode == 'ar'
            ? "من فضلك تأكد من البيانات"
            : "Please confirme your data",
      );
    }
    notifyListeners();
  }

///////////////////////////////////// Register /////////////////////////////
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerMobileController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerAddressController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  var _cityId;
  setCityId(city_id) {
    _cityId = city_id;
    notifyListeners();
  }

  void registerSubmit({@required context, @required scaffoldkey}) async {
    if (registerFirstNameController.text != null
    // &&
        // registerFirstNameController.text.isNotEmpty &&
        // registerLastNameController.text.isNotEmpty &&
        // registerLastNameController.text != null &&
        // registerEmailController.text != null &&
        // registerEmailController.text.isNotEmpty &&
        // registerPasswordController.text != null &&
        // registerPasswordController.text.isNotEmpty &&
        // registerMobileController.text != null &&
        // registerMobileController.text.isNotEmpty
    ) {
      newRgister(
        context,
      ).then((val) {
        registerFirstNameController.clear();
        registerEmailController.clear();
        registerMobileController.clear();
        registerPasswordController.clear();
        registerAddressController.clear();
       });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: AppLocalizations.of(context).locale.languageCode == 'ar'
            ? Text(
                'من فضلك تأكد من البيانات',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoKufiArabic-Light'),
              )
            : Text('Please confirm your data'),
      )) ;
    }
    notifyListeners();
  }

// Logout
  Future logout({context, locale, scaffoldKey, userId}) async {
    this.authStage = AuthControllerStage.LOADING;
    String url = '$domain/logout';

    var headers = {
      'api_password': '${apiPassword}',
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    print(LocaleStorage.token);
    var formData = FormData.fromMap({'token': LocaleStorage.token});

    var token = await LocaleStorage.getUserTokenInSharedPreferences();

    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              responseType: ResponseType.bytes,
              validateStatus: (status) => true,
              headers: headers));
      var responseJsonn = response.data;
      var convertedResponse = utf8.decode(responseJsonn);
      var responseJson = json.decode(convertedResponse);

      print(responseJson);
      if (response.statusCode == 200 && responseJson['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        this.authStage = AuthControllerStage.DONE;
      } else {}
    } catch (e) {
      this.authStage = AuthControllerStage.ERROR;
      print(e);
      throw e;
    }
    notifyListeners();
  }

  newRgister(context) async {
    try{
    authStage = AuthControllerStage.LOADING;
    final imagePickerController =
        Provider.of<ImagePickerController>(context, listen: false);
    var headers = {'api_password': '123456', 'language': 'ar'};
    var request = http.MultipartRequest('POST', Uri.parse('$domain/register'));
    request.fields.addAll({
      'first_name': '${registerFirstNameController.text}',
      'last_name': '${registerLastNameController.text}',
      'email': '${registerEmailController.text}',
      'city_id': '$_cityId',
      'mobile': '${registerMobileController.text}',
      'password': '${registerPasswordController.text}',
      'password_confirmation': '${registerPasswordController.text}',
      "address": "${registerAddressController.text}",
      'fcm_token': '${FirebaseMessagingService.instance.fcmToken}',
      // "image": 'image',
      // "national_identifier_back_image": 'national_identifier_back_image',
      // "national_identifier_front_image": 'national_identifier_front_image',

    });

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

    print(request.fields);
    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(responseString);
    final prefs = await SharedPreferences.getInstance();

      print(response.statusCode);
    if (response.statusCode == 200) {
      if (responseMap['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: AppLocalizations
              .of(context)
              .locale
              .languageCode == 'en'
              ? Text(
            'successfully registered',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'NotoKufiArabic-Light',
              color: Colors.white,
            ),
          )
              : Text(
            'تم التسجيل بنجاح',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'NotoKufiArabic-Light',
              color: Colors.white,
            ),
          ),
        ));
        fadNavigate(context, LoginScreen());
      }else {
        final errorMessage = responseMap['message'];
        final errorNumber = responseMap['errorNumber'];
        final snackBar = SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Registration failed. Error number: $errorNumber, Error message: $errorMessage');
      }

      this.authStage = AuthControllerStage.DONE;

     } else {
      this.authStage = AuthControllerStage.ERROR;
      Alert(
        context: context,
        type: AlertType.error,
        desc: "${responseMap['message']}",
        style: AlertStyle(descStyle: TextStyle(fontSize: 14)),
        buttons: [
          DialogButton(
            child: Text(
              "${AppLocalizations.of(context).trans('ok')}",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
    notifyListeners();
    }catch(e){
     print(e);
        }
    }
  //   newRgister(context)async{
  //
  //        final url = Uri.parse('$domain/register');
  //       final headers = {'api_password': '123456', 'language': 'ar'};
  //       final body = {
  //         'first_name': '{registerFirstNameController.text}',
  //         'last_name': ' {registerLastNameController.text}',
  //         'email': 'tttttttt@mmmmm.com',
  //         'city_id': ' _cityId',
  //         'mobile': '0663663636366',
  //         'password': '123456',
  //         'password_confirmation': '123456',
  //         "address": " ${registerAddressController.text}",
  //         'fcm_token': ' FirebaseMessagingService.instance.fcmToken}',
  //         "image": 'image',
  //         "national_identifier_back_image": 'national_identifier_back_image',
  //         "national_identifier_front_image": 'national_identifier_front_image',
  //       };
  //
  //       final response = await http.post(url, headers: headers, body: body);
  //       // print(response.body);
  //       // if(response.statusCode==200){
  //       //   print('okayyy');
  //         print(response.body);
  //         print(response.statusCode);
  //       // }
  //       // else{
  //       //   print(response.body);
  //       // }
  //     }

  Future updateUserPassword(context, password, passwordConfirmation) async {
    this.authStage = AuthControllerStage.LOADING;
    var headers = {
      'Authorization': 'Bearer ${LocaleStorage.token}',
      'api_password': '$apiPassword',
      'language':
          '${Provider.of<LocalizationController>(context, listen: false).locale}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$domain/update-password'));
    request.fields.addAll({
      'password': '$password',
      'password_confirmation': '$passwordConfirmation'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic responseMap = json.decode(responseString);
    print(request.headers);
    print(responseMap);
    if (response.statusCode == 200) {
      if (responseMap['user']["api_token"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color1,
          content: Text(
            '${responseMap['message']}',
            style: TextStyle(fontFamily: 'NotoKufiArabic-Light'),
          ),
        ));
      }

      this.authStage = AuthControllerStage.DONE;
    } else {
      this.authStage = AuthControllerStage.ERROR;
    }
  }
}
