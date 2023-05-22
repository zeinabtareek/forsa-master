import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/NotificationsServices/firebase_messaging_service.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/IntroScreens/RegisterScreen.dart/RegisterScreen.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getFcm();
    getCurrentLanguage();
    _navigateToNextScreen();
  }

  getFcm() async {
    await FirebaseMessagingService.instance.getToken();
  }

  var _locale;

  Future getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language');
    if (language != null) {
      Provider.of<LocalizationController>(context, listen: false)
          .setLocale(Locale(language))
          .then((value) {
        _locale =
            Provider.of<LocalizationController>(context, listen: false).locale;
      });
    } else {
      _locale =
          Provider.of<LocalizationController>(context, listen: false).locale;
    }
  }

  _navigateToNextScreen() async {
    Provider.of<SettingsController>(context, listen: false)
        .getAppSettings(context: context);
    Timer(Duration(milliseconds: 5000), () {
      Provider.of<AuthController>(context, listen: false)
          .getUserData()
          .then((value) {
        if (LocaleStorage.is_loggedIn == true) {
          print(
              '${Provider.of<LocalizationController>(context, listen: false).locale}');

          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    NavigationHomeScreen(),
                transitionDuration: Duration(milliseconds: 1000),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => LoginScreen(),
                transitionDuration: Duration(milliseconds: 1000),
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: media.width,
        height: media.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/Splash.png',
                fit: BoxFit.cover,
              ),
            ),

            // Image.asset(
            //   'images/snap.png',
            //   width: 120,
            // )
          ],
        ),
      ),
    );
  }
}
