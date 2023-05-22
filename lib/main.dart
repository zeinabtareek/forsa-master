import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Controller/CartController.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/ChecoutController.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/OffersController.dart';
import 'package:fursa/Controller/OrderController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Controller/UserDataController.dart';
import 'package:fursa/Controller/WinnersController.dart';
import 'package:fursa/Controller/deal_controller.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:provider/provider.dart';

import 'Controller/pageIndexController.dart';
import 'Core/Services/NotificationsServices/firebase_messaging_service.dart';
import 'Core/Services/NotificationsServices/local_notification_service.dart';
import 'Core/Services/localizationServices/app_localization_delegate.dart';
import 'View/IntroScreens/SplashScreen/SplashScreen.dart';

const domain = "https://fursah.ae/api";
// const domain = "https://ebtasm.com/fursa/public/api";
const apiPassword = '123456';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessagingService.instance.initFirebaseMessaging();
  await LocalNotificationService.instance.initNotificationSettings();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationController>(
            create: (_) => LocalizationController()),
        ChangeNotifierProvider<PageIndexController>(
            create: (_) => PageIndexController()),
        ChangeNotifierProvider<DealController>(create: (_) => DealController()),
        ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
        ChangeNotifierProvider<CategoryController>(
            create: (_) => CategoryController()),
        ChangeNotifierProvider<UserDataController>(
            create: (_) => UserDataController()),
        ChangeNotifierProvider<CartController>(create: (_) => CartController()),
        ChangeNotifierProvider<SettingsController>(
            create: (_) => SettingsController()),
        ChangeNotifierProvider<ProductsController>(
            create: (_) => ProductsController()),
        ChangeNotifierProvider<OffersController>(
            create: (_) => OffersController()),
        ChangeNotifierProvider<CartController>(create: (_) => CartController()),
        ChangeNotifierProvider<MyProductsController>(
            create: (_) => MyProductsController()),
        ChangeNotifierProvider<ImagePickerController>(
            create: (_) => ImagePickerController()),
        ChangeNotifierProvider<CheckoutController>(
            create: (_) => CheckoutController()),
        ChangeNotifierProvider<OrderController>(
            create: (_) => OrderController()),
        ChangeNotifierProvider<WinnersController>(
            create: (_) => WinnersController())
      ],
      child: Consumer<LocalizationController>(
          builder: (context, localProvider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'fursa',
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: localProvider.locale,
          theme: ThemeData(
            fontFamily: 'NotoKufiArabic-Light',
          ),
          home: SplashScreen(),
        );
      }),
    );
  }
}
