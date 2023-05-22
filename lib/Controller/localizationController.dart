import 'package:flutter/material.dart';

class LocalizationController extends ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  Future setLocale(Locale locale, {save = true}) async {
    try {
      _locale = locale;

      notifyListeners();

      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
