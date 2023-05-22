import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/OffersController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/MainCategoryModel.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreenComponents/CategoriesWidget.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreenComponents/HomeCard.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreenComponents/NotificationWidget.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreenComponents/OffersWidget.dart';
import 'package:fursa/View/MainScreens/HomeScreen/HomeScreenComponents/ProfileWidget.dart';
import 'package:fursa/View/MainScreens/HomeScreen/LatestProducsWidget/LatestProducsWidget.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:fursa/View/SubScreens/NotificationScreen/NotificationScreen.dart';
import 'package:fursa/View/SubScreens/ProfileScreen/ProfileScreen.dart';
import 'package:fursa/View/SubScreens/WinnersScreen/WinnersScreen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderCurrentIndex = 0;
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    Provider.of<ProductsController>(context, listen: false)
        .getLatestProductList(context: context);
    Provider.of<OffersController>(context, listen: false)
        .getOffers(context: context);
    Provider.of<SettingsController>(context, listen: false)
        .getHomeScreenSlider(context: context);
    Provider.of<CategoryController>(context, listen: false)
        .getSomeMainCategory(context: context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Consumer2<CategoryController, SettingsController>(
      builder: (context, categoryController, settingsController, child) =>
          Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: settingsController.settingStage == SettingsControllerStage.LOADING
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: standaredBoxShadow,
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: buttonColor1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Loading',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _scrollPosition < 60 ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      height: 300,
                      margin: EdgeInsets.only(top: 98),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF00489A), Color(0xFF1D6BC3)],
                          // tileMode: TileMode.clamp,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 90.0,
                    start: 0.0,
                    child: Image.asset(
                      'images/ring1.png',
                      width: 160,
                    ),
                  ),
                  PositionedDirectional(
                    top: 150,
                    end: 0.0,
                    child: Image.asset(
                      'images/ring2.png',
                      width: 140,
                    ),
                  ),
                  settingsController.settingStage ==
                              SettingsControllerStage.LOADING &&
                          categoryController.categoryStage ==
                              CategoryControllerStage.LOADING
                      ? CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              backgroundColor: Color(0xFF00489A),
                              title: Text(
                                '${AppLocalizations.of(context).trans('Fursa')}',
                                style: cairoW400(
                                  size: 24,
                                ),
                              ),
                              toolbarHeight: 74,
                              centerTitle: true,
                              pinned: true,
                              leading: LocaleStorage.token == null
                                  ? SizedBox()
                                  : ProfileWdget(
                                      onPressed: () {
                                        fadNavigate(context, ProfileScreen());
                                      },
                                    ),
                              actions: [
                                LocaleStorage.token == null
                                    ? SizedBox()
                                    : NotificationWidget(
                                        onPressed: () {
                                          fadNavigate(
                                              context, NotificationScreen());
                                        },
                                      ),
                              ],
                            ),
                          ],
                        )
                      : CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          slivers: [
                            SliverAppBar(
                              backgroundColor: Color(0xFF00489A),
                              title: Text(
                                '${AppLocalizations.of(context).trans('Fursa')}',
                                style: cairoW400(
                                  size: 24,
                                ),
                              ),
                              toolbarHeight: 74,
                              centerTitle: true,
                              pinned: true,
                              leading: LocaleStorage.token == null
                                  ? SizedBox()
                                  : ProfileWdget(
                                      onPressed: () {
                                        fadNavigate(context, ProfileScreen());
                                      },
                                    ),
                              actions: [
                                LocaleStorage.token == null
                                    ? SizedBox()
                                    : NotificationWidget(
                                        onPressed: () {
                                          fadNavigate(
                                              context, NotificationScreen());
                                        },
                                      ),
                              ],
                            ),
                            settingsController.settingStage ==
                                    SettingsControllerStage.LOADING
                                ? SliverToBoxAdapter()
                                : SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('explore')}',
                                            style: cairoW700(
                                                color: Color(0xFFFFD954),
                                                size: 25),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('bestDeals')}',
                                            style: cairoW700(
                                                color: Color(0xFFFFD954),
                                                size: 16),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CarouselSlider(
                                            items: List.generate(
                                                settingsController
                                                    .slider.data.length,
                                                (index) => HomeCard(
                                                    settingsController
                                                        .slider.data[index])),
                                            options: CarouselOptions(
                                              aspectRatio: 1.45,
                                              viewportFraction: .95,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: false,
                                              autoPlayInterval:
                                                  Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enlargeCenterPage: false,
                                              onPageChanged: (int i, test) {
                                                setState(() {
                                                  sliderCurrentIndex = i;
                                                });
                                              },
                                              scrollDirection: Axis.horizontal,
                                            )),
                                        settingsController.settingStage ==
                                                SettingsControllerStage.LOADING
                                            ? Container()
                                            : Container(
                                                height: 30,
                                                width: media.width,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      AnimatedSmoothIndicator(
                                                    activeIndex:
                                                        sliderCurrentIndex,
                                                    count: settingsController
                                                        .slider.data.length,
                                                    effect: WormEffect(
                                                      activeDotColor: color1,
                                                      dotColor:
                                                          Colors.grey[600],
                                                      radius: 8,
                                                      spacing: 10,
                                                      dotHeight: 8,
                                                      dotWidth: 8,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                            settingsController.settingStage ==
                                        SettingsControllerStage.LOADING &&
                                    categoryController.categoryStage ==
                                        CategoryControllerStage.LOADING
                                ? Container()
                                : CategoryWidget(),
                            SliverToBoxAdapter(
                              child: InkWell(
                                onTap: () {
                                  fadNavigate(context, WinnersScreen());
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: media.width,
                                              height: 120,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      image: AssetImage(
                                                          'images/positiveMan.png')),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        buttonColor1,
                                                        buttonColor2
                                                      ])),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 50.0,
                                        bottom: 40,
                                        child: Image.asset(
                                          'images/jeep.png',
                                          width: 160,
                                          height: 130,
                                        ),
                                      ),
                                      Positioned(
                                        right: 40.0,
                                        bottom: 25,
                                        child: Image.asset(
                                          'images/mobiles.png',
                                          width: 100,
                                        ),
                                      ),
                                      Positioned(
                                        left: 20.0,
                                        bottom: 20.0,
                                        child: Image.asset(
                                          'images/winners.png',
                                          width: 200,
                                          height: 120,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 0.0),
                                    child: Text(
                                      '${AppLocalizations.of(context).trans('latestDeals')}',
                                      style: cairoW600(
                                          color: Colors.black, size: 14),
                                    ),
                                  ),
                                  OffersWidget(),
                                  LatestProductWidget()
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 200,
                                ),
                              ),
                            )
                          ],
                        ),
                ],
              ),
      ),
    );
  }
}
