import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/OffersController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Controller/UserDataController.dart';
import 'package:fursa/Controller/pageIndexController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/add_deal_screen.dart';
import 'package:fursa/View/MainScreens/CartScreen/CartScreen.dart';
import 'package:fursa/View/MainScreens/CouponsScreen/CouponsScreen.dart';
import 'package:fursa/View/MainScreens/DrawScreen/DrawScreen.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreen.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/MyProducts/MyProductsScreen.dart';
import 'package:fursa/View/SubScreens/OrdersScreen/MyOrdersScreen.dart';
import 'package:provider/provider.dart';

import 'TabClipper.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  @override
  void initState() {
    Provider.of<UserDataController>(context, listen: false).checkIfUserAuthed(
        Provider.of<UserDataController>(context, listen: false)
            .getUserData(context: context));

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  List<Widget> _pages = [
    HomeScreen(),
    MyProductsScreen(),
    MyOrdersScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer2<PageIndexController, CategoryController>(
      builder: (ctx, pageIndexControl, categoryController, ch) {
        return Scaffold(
          body: _pages[pageIndexControl.index],
          extendBody: true,
          resizeToAvoidBottomInset: true, // fluter 2.x
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: categoryController.categoryStage ==
                  CategoryControllerStage.LOADING
              ? Container()
              : InkWell(
                  onTap: () {
                    fadNavigate(context, AddDealScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff00489A),
                      ),
                      child: Image.asset(
                        'images/add_white.png',
                        // width: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: categoryController.categoryStage ==
                  CategoryControllerStage.LOADING
              ? Container()
              : ClipPath(
                  clipper: TabClipper(),
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: standaredBoxShadow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              pageIndexControl.changeIndexFunction(0);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: pageIndexControl.index == 0
                                              ? Color(0xff00489A)
                                              : Colors.transparent),
                                    ),
                                  ),
                                ),
                                pageIndexControl.index == 0
                                    ? Image.asset(
                                        'images/home.png',
                                        color: Color(0xff00489A),
                                        width: 25,
                                      )
                                    : Image.asset(
                                        'images/nav_icon_home_not_active.png',
                                        color: Color(0xffB3B3B3),
                                        width: 25,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('home')}',
                                    style: cairoW700(
                                      color: pageIndexControl.index == 0
                                          ? Color(0xFF00489A)
                                          : Color(0xFFB3B3B3),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 1),
                          InkWell(
                            onTap: () {
                              pageIndexControl.changeIndexFunction(1);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: pageIndexControl.index == 1
                                              ? Color(0xff00489A)
                                              : Colors.transparent),
                                    ),
                                  ),
                                ),
                                pageIndexControl.index == 1
                                    ? Image.asset(
                                        'images/products2.png',
                                        width: 25,
                                        color: Color(0xff00489A),
                                      )
                                    : Image.asset(
                                        'images/products1.png',
                                        width: 25,
                                        color: Color(0xffB3B3B3),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('myProducts')}',
                                    style: cairoW700(
                                      color: pageIndexControl.index == 1
                                          ? Color(0xFF00489A)
                                          : Color(0xFFB3B3B3),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 4),
                          InkWell(
                            onTap: () {
                              pageIndexControl.changeIndexFunction(2);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: pageIndexControl.index == 2
                                              ? Color(0xff00489A)
                                              : Colors.transparent),
                                    ),
                                  ),
                                ),
                                pageIndexControl.index == 2
                                    ? Image.asset(
                                        'images/nav_icon_bag_active.png',
                                        width: 25,
                                        color: Color(0xff00489A),
                                      )
                                    : Image.asset(
                                        'images/bag.png',
                                        width: 25,
                                        color: Color(0xffB3B3B3),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('orders')}',
                                    style: cairoW700(
                                      color: pageIndexControl.index == 2
                                          ? Color(0xFF00489A)
                                          : Color(0xFFB3B3B3),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 1),
                          InkWell(
                            onTap: () {
                              pageIndexControl.changeIndexFunction(3);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: pageIndexControl.index == 3
                                              ? Color(0xff00489A)
                                              : Colors.transparent),
                                    ),
                                  ),
                                ),
                                pageIndexControl.index == 3
                                    ? Image.asset(
                                        'images/cart2.png',
                                        width: 25,
                                        color: Color(0xff00489A),
                                      )
                                    : Image.asset(
                                        'images/cart1.png',
                                        width: 25,
                                        color: Color(0xffB3B3B3),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('cart2')}',
                                    style: cairoW700(
                                      color: pageIndexControl.index == 3
                                          ? Color(0xFF00489A)
                                          : Color(0xFFB3B3B3),
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
