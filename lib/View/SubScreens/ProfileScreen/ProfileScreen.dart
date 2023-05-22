import 'package:flutter/material.dart';
import 'package:fursa/Controller/UserDataController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/Dialog/logout_dialog.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/ChangePassword/change_password_screen.dart';
import 'package:fursa/View/SubScreens/ContactUS/ContactUsScreen.dart';
import 'package:fursa/View/SubScreens/Languagescreen/LanguageScreen.dart';
import 'package:fursa/View/SubScreens/MyProducts/MyProductsScreen.dart';
import 'package:fursa/View/SubScreens/OrdersScreen/MyOrdersScreen.dart';
import 'package:fursa/View/SubScreens/ProfileDetails/ProfileDetails.dart';
import 'package:provider/provider.dart';

import 'ProfileCard.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<UserDataController>(
      builder: (context, userData, child) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff00489A),
              title: Text('${AppLocalizations.of(context).trans('profile')}',
                  style: cairoW400()),
              centerTitle: true,
              toolbarHeight: 80,
              leading:
                  Provider.of<LocalizationController>(context, listen: false)
                              .locale
                              .languageCode ==
                          'en'
                      ? InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10),
                            child: Container(
                              width: 20,
                              height: 20,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xFF195AA4),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  'images/arrow_left.png',
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
              actions: [
                Provider.of<LocalizationController>(context, listen: false)
                            .locale
                            .languageCode ==
                        'en'
                    ? const SizedBox()
                    : InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 10, bottom: 10),
                          child: Container(
                            width: 46,
                            height: 46,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color(0xFF195AA4),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Image.asset(
                                'images/arrow_left.png',
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            LocaleStorage.token == null
                ? SliverToBoxAdapter()
                : SliverToBoxAdapter(
                    child: Container(
                      color: Color(0xff00489A),
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CustomFadNetWorkImage(
                              width: 120.0,
                              height: 120.0,
                              boxFit: BoxFit.cover,
                              imagePath:
                                  '${userData.userProfileDetails.user.image}',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${LocaleStorage.userEmail}',
                            style: cairoW400(size: 14),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, ProfileDetails());
                    },
                    child: ProfileCard(
                      title: 'personalDetails',
                      image: 'images/user.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, MyProductsScreen());
                      //MyCardsScreen
                    },
                    child: ProfileCard(
                      title: 'myProducts',
                      image: 'images/products1.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, MyOrdersScreen());
                      //MyCardsScreen
                    },
                    child: ProfileCard(
                      title: 'orders',
                      image: 'images/bag.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, ChangePasswordScreen());
                      //MyCardsScreen
                    },
                    child: ProfileCard(
                      title: 'changePassword',
                      image: 'images/lock.png',
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      fadNavigate(context, LanguageScreen());
                    },
                    child: LanguageCard(media: media),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     fadNavigate(context, MyProductsScreen());
                  //     //MyCardsScreen
                  //   },
                  //   child: ProfileCard(
                  //     title: 'settings',
                  //     image: 'images/my_setting.png',
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, ContactUsScreen());
                    },
                    child: ProfileCard(
                      title: 'contact_us',
                      image: 'images/sms.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logoutDialog(context: context);
                    },
                    child: ProfileCard(
                      title: 'logout',
                      image: 'images/logout.png',
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    Key key,
    @required this.media,
  }) : super(key: key);

  final Size media;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: Container(
        width: media.width,
        height: media.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: standaredBoxShadow,
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Transform.scale(
                scale: 0.7,
                child: Image.asset(
                  'images/language.png',
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            Text(
              '${AppLocalizations.of(context).trans('app_language')}',
              style: cairoW400(color: Color(0xFF4D4D4D)),
            ),
            Spacer(),
            Provider.of<LocalizationController>(context, listen: false)
                        .locale
                        .languageCode ==
                    'en'
                ? Text(
                    'English',
                    style: cairoW400(color: Color(0xFF00489A)),
                  )
                : Text(
                    'العربية',
                    style: cairoW400(color: Color(0xFF00489A)),
                  ),
            Provider.of<LocalizationController>(context, listen: false)
                        .locale
                        .languageCode ==
                    'en'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset(
                        'images/arrow-right.png',
                        width: 30,
                        height: 30,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset(
                        'images/arrow-right-ar.png',
                        width: 30,
                        height: 30,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
