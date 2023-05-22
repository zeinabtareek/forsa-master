import 'dart:ui';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/CartController.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/OffersController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/MainCategoryDetailsModel.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SharedComponents/ScreenLoader.dart';
import 'package:fursa/View/SubScreens/BindingScreen/BindingScreen.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubCategoryScreen extends StatefulWidget {
  final title;

  const SubCategoryScreen({Key key, this.title}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int tabIndex = 0;
  List<SubCategories> tabs = [];
  bool _screenLoader = false;
  @override
  void initState() {
    tabs.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryController>(context, listen: false).resetSubCatId();
    });

    Provider.of<CategoryController>(context, listen: false)
        .getMainCategoryDetails(context: context)
        .then((_) {
      tabs = Provider.of<CategoryController>(context, listen: false)
          .mainCategoryDetails
          .data
          .subCategories;
      if (Provider.of<LocalizationController>(context, listen: false)
              .locale
              .languageCode ==
          'en') {
        tabs.insert(0, SubCategories(id: 0, title: 'all'));
      } else {
        tabs.insert(0, SubCategories(id: 0, title: 'الكل'));
      }
    });

    super.initState();
  }

  int subCatindex;
  void _onRefresh() async {
    Provider.of<OffersController>(context, listen: false)
        .getOffers(context: context);
    // Provider.of<AuctionsProvider>(context, listen: false).clearMyAuctions();
    Provider.of<OffersController>(context, listen: false)
        .getOffers(context: context);
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  int nextPage = 1;
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<CategoryController>(context, listen: false).nextPage;
    if (nextPage != null) {
      Provider.of<CategoryController>(context, listen: false)
          .getSubCategoryProducts(
              currentPageNumber: nextPage, context: context);
      if (mounted) {
        setState(() {});
        _refreshController.loadComplete();
      }
    } else {
      if (mounted) {
        setState(() {});
        _refreshController.loadNoData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer2<CategoryController, CartController>(
      builder:
          (context, categoryController, cartController, child) =>
              categoryController.categoryDetailsSatge ==
                      CategoryControllerStage.LOADING
                  ? Scaffold(
                      body: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: color1,
                            title: Text('${widget.title}', style: cairoW400()),
                            centerTitle: true,
                            toolbarHeight: 74,
                            pinned: true,
                            leading: Provider.of<LocalizationController>(
                                            context,
                                            listen: false)
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
                              Provider.of<LocalizationController>(context,
                                              listen: false)
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
                          SliverToBoxAdapter(
                              child: Container(
                            width: media.width,
                            height: media.height * 0.8,
                            child: Center(
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    )
                  : DefaultTabController(
                      initialIndex: 0,
                      length: categoryController.mainCategoryDetails != null
                          ? tabs.length
                          : 0,
                      child: Scaffold(
                        backgroundColor: Color(0xffE5E5E5),
                        body: CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              backgroundColor: color1,
                              title:
                                  Text('${widget.title}', style: cairoW400()),
                              centerTitle: true,
                              toolbarHeight: 74,
                              pinned: true,
                              leading: Provider.of<LocalizationController>(
                                              context,
                                              listen: false)
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
                                Provider.of<LocalizationController>(context,
                                                listen: false)
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
                            tabs.isEmpty
                                ? SliverToBoxAdapter(
                                    child: Container(
                                      width: media.width,
                                      height: media.height * 0.8,
                                      child: Center(
                                        child: Text(
                                          'عفوا لا يوجود منتجات في هذا القسم',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  )
                                : SliverFillRemaining(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          Align(
                                            alignment:
                                                AppLocalizations.of(context)
                                                            .locale
                                                            .languageCode ==
                                                        'ar'
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: ButtonsTabBar(
                                                  onTap: (index) {
                                                    setState(() {
                                                      tabIndex = index;
                                                    });
                                                    if (index != 0) {
                                                      categoryController
                                                          .setSubcategoryId(
                                                              tabs[index]
                                                                  .id
                                                                  .toString());
                                                      categoryController
                                                          .getSubCategoryProducts(
                                                              context: context);
                                                      print(tabs[index].title);
                                                    } else {
                                                      categoryController
                                                          .resetSubCatId();
                                                      categoryController
                                                          .updateMainCategoryDetails(
                                                              context: context);
                                                    }
                                                  },
                                                  backgroundColor: buttonColor1,
                                                  center: false,
                                                  unselectedBackgroundColor:
                                                      Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  unselectedLabelStyle:
                                                      TextStyle(
                                                          color:
                                                              Colors.blue[600],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  // borderWidth: 1,
                                                  // unselectedBorderColor: Colors.blue[600],
                                                  radius: 10,
                                                  tabs: List.generate(
                                                    tabs.length,
                                                    (index) => Tab(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          child: Text(
                                                            '${tabs[index].title}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Flexible(
                                            child: categoryController
                                                        .subCategoryId ==
                                                    null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: TabBarView(
                                                        children: List.generate(
                                                      tabs.length,
                                                      (index) =>
                                                          SingleChildScrollView(
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        child: Column(
                                                          children:
                                                              List.generate(
                                                            categoryController
                                                                .mainCategoryDetails
                                                                .data
                                                                .products
                                                                .data
                                                                .length,
                                                            (index) => InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                margin: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15) +
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                width:
                                                                    media.width,
                                                                height: 400,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow:
                                                                        standaredBoxShadow),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child: CustomFadNetWorkImage(
                                                                            imagePath:
                                                                                '${categoryController.mainCategoryDetails.data.products.data[index].image}',
                                                                            width:
                                                                                double.maxFinite,
                                                                            boxFit: BoxFit.cover,
                                                                            height: 140.0),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15.0,
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            '${categoryController.mainCategoryDetails.data.products.data[index].title}',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Text(
                                                                            '${categoryController.mainCategoryDetails.data.products.data[index].price} ${AppLocalizations.of(context).trans('aed')}',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15.0,
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${categoryController.mainCategoryDetails.data.products.data[index].paidCoupons}',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                            '/ ${categoryController.mainCategoryDetails.data.products.data[index].couponsCount} ${AppLocalizations.of(context).trans('coupons')}',
                                                                            style: TextStyle(
                                                                                color: Colors.black54,
                                                                                fontSize: 13,
                                                                                height: 1.6,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              4),
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            LinearPercentIndicator(
                                                                          progressColor:
                                                                              buttonColor1,
                                                                          percent:
                                                                              0.35,
                                                                          animation:
                                                                              true,
                                                                          animationDuration:
                                                                              1200,
                                                                          backgroundColor:
                                                                              Color(0xffD9D9D9),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child: Container(
                                                                          width: 220,
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Text(
                                                                                '${categoryController.mainCategoryDetails.data.products.data[index].days} ${AppLocalizations.of(context).trans('days')}',
                                                                                style: TextStyle(color: Color(0xffEA0101), fontSize: 14),
                                                                              ),
                                                                              Text(
                                                                                '${categoryController.mainCategoryDetails.data.products.data[index].hours} ${AppLocalizations.of(context).trans('hours')}',
                                                                                style: TextStyle(color: Color(0xffEA0101), fontSize: 14),
                                                                              ),
                                                                              Text(
                                                                                '${categoryController.mainCategoryDetails.data.products.data[index].minutes} ${AppLocalizations.of(context).trans('minutes')}',
                                                                                style: TextStyle(color: Color(0xffEA0101), fontSize: 14),
                                                                              )
                                                                            ],
                                                                          )),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    DefaultAppButton(
                                                                      onPressed:
                                                                          () {
                                                                        fadNavigate(
                                                                            context,
                                                                            DealDetails(
                                                                              title: categoryController.mainCategoryDetails.data.products.data[index].title,
                                                                              productId: categoryController.mainCategoryDetails.data.products.data[index].id,
                                                                            ));
                                                                      },
                                                                      text:
                                                                          'product_details',
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  )
                                                : categoryController
                                                        .subCatProductsList
                                                        .isEmpty
                                                    ? Container(
                                                        width: media.width,
                                                        height:
                                                            media.height * 0.7,
                                                        child: Center(
                                                          child: Text(
                                                              'عفوا لا يوجود منتجات في هذا القسم'),
                                                        ),
                                                      )
                                                    : categoryController
                                                                .updateProductsStage ==
                                                            CategoryControllerStage
                                                                .LOADING
                                                        ? Container(
                                                            width: media.width,
                                                            height:
                                                                media.height *
                                                                    0.8,
                                                            child: Center(
                                                              child: Container(
                                                                height: 100,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    boxShadow:
                                                                        standaredBoxShadow,
                                                                    color: Colors
                                                                        .white),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator(
                                                                      color:
                                                                          buttonColor1,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Loading',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : TabBarView(
                                                            children:
                                                                List.generate(
                                                            tabs.length,
                                                            (index) =>
                                                                SmartRefresher(
                                                              enablePullDown:
                                                                  true,
                                                              enablePullUp:
                                                                  true,
                                                              controller:
                                                                  _refreshController,
                                                              onRefresh:
                                                                  _onRefresh,
                                                              onLoading:
                                                                  _onLoading,
                                                              footer:
                                                                  CustomFooter(
                                                                height: 100,
                                                                builder: (BuildContext
                                                                        context,
                                                                    LoadStatus
                                                                        mode) {
                                                                  Widget body;
                                                                  if (mode ==
                                                                      LoadStatus
                                                                          .idle) {
                                                                    body = Text(AppLocalizations.of(
                                                                            context)
                                                                        .trans(
                                                                            "swipe_up"));
                                                                  } else if (mode ==
                                                                      LoadStatus
                                                                          .loading) {
                                                                    body =
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          CupertinoActivityIndicator(),
                                                                    );
                                                                  } else if (mode ==
                                                                      LoadStatus
                                                                          .failed) {
                                                                    body = Text(
                                                                        "Load Failed!Click retry!");
                                                                  } else if (mode ==
                                                                      LoadStatus
                                                                          .canLoading) {
//                                      body = Text("");
                                                                  } else {
                                                                    body = Text(AppLocalizations.of(
                                                                            context)
                                                                        .trans(
                                                                            "no_more_notifications"));
                                                                  }
                                                                  return Container(
                                                                    height: 1.0,
                                                                    child: Center(
                                                                        child:
                                                                            body),
                                                                  );
                                                                },
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                physics:
                                                                    BouncingScrollPhysics(),
                                                                child: Column(
                                                                  children: List
                                                                      .generate(
                                                                    categoryController
                                                                        .subCatProductsList
                                                                        .length,
                                                                    (index) =>
                                                                        InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            const EdgeInsets.all(20),
                                                                        width: media
                                                                            .width,
                                                                        height:
                                                                            380,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16),
                                                                            color: Colors.white,
                                                                            boxShadow: standaredBoxShadow),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                child: CustomFadNetWorkImage(imagePath: '${categoryController.subCatProductsList[index].image}', width: double.maxFinite, boxFit: BoxFit.cover, height: 120.0),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    '${categoryController.subCatProductsList[index].title}',
                                                                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  Text(
                                                                                    '${categoryController.subCatProductsList[index].price} ${AppLocalizations.of(context).trans('aed')}',
                                                                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    '${categoryController.subCatProductsList[index].paid_coupons}',
                                                                                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 4,
                                                                                  ),
                                                                                  Text(
                                                                                    '/ ${categoryController.subCatProductsList[index].coupons_count}  ${AppLocalizations.of(context).trans('coupons')}',
                                                                                    style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.6, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                                              child: Container(
                                                                                child: LinearPercentIndicator(
                                                                                  progressColor: buttonColor1,
                                                                                  percent: 0.5,
                                                                                  animation: true,
                                                                                  animationDuration: 1200,
                                                                                  backgroundColor: Color(0xffD9D9D9),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Container(
                                                                                width: 200,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Text(
                                                                                      '${categoryController.subCatProductsList[index].days} ${AppLocalizations.of(context).trans('days')}',
                                                                                      style: TextStyle(
                                                                                          color: Color(
                                                                                            0xffEA0101,
                                                                                          ),
                                                                                          fontSize: 12),
                                                                                    ),
                                                                                    Text(
                                                                                      '${categoryController.subCatProductsList[index].hours} ${AppLocalizations.of(context).trans('hours')}',
                                                                                      style: TextStyle(color: Color(0xffEA0101), fontSize: 12),
                                                                                    ),
                                                                                    Text(
                                                                                      '${categoryController.subCatProductsList[index].minutes} ${AppLocalizations.of(context).trans('minutes')}',
                                                                                      style: TextStyle(color: Color(0xffEA0101), fontSize: 12),
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            DefaultAppButton(
                                                                              onPressed: () {
                                                                                fadNavigate(
                                                                                    context,
                                                                                    DealDetails(
                                                                                      productId: categoryController.subCatProductsList[index].id,
                                                                                      title: categoryController.subCatProductsList[index].title,
                                                                                    ));
                                                                              },
                                                                              text: 'product_details',
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
    );
  }
}
