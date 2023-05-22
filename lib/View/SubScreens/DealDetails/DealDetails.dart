import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/CartController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/ScreenLoader.dart';
import 'package:fursa/View/TestClipper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DealDetails extends StatefulWidget {
  final productId;
  final title;
  DealDetails({this.productId, this.title});
  @override
  State<DealDetails> createState() => _DealDetailsState();
}

class _DealDetailsState extends State<DealDetails> {
  int carouselSliderCurrentIndex = 0;
  bool loader = false;
  @override
  void initState() {
    Provider.of<ProductsController>(context, listen: false)
        .getProductDetails(context: context, productId: widget.productId);
    super.initState();
  }

  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Consumer2<ProductsController, CartController>(
      builder: (context, productsController, cartController, child) => Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: Stack(
          children: [
            Container(
              height: 300,
              decoration: defaultGregientContainer,
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Color(0xff00489A).withOpacity(.1),
                  title: Text('${widget.title}', style: cairoW400(size: 18)),
                  centerTitle: true,
                  pinned: true,
                  toolbarHeight: 74,
                  leading: Provider.of<LocalizationController>(context,
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
                productsController.productStage ==
                        ProductsControllerStage.LOADING
                    ? ScrreenLoader()
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Ticket(
                            top: Container(
                              height: productsController
                                      .productDetails.data.productImages.isEmpty
                                  ? 400
                                  : 390,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  productsController.productDetails.data
                                          .productImages.isEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomFadNetWorkImage(
                                              imagePath:
                                                  '${productsController.productDetails.data.productDetails.image}',
                                              width: media.width,
                                              boxFit: BoxFit.cover,
                                              height: 160.0,
                                            ),
                                          ),
                                        )
                                      : CarouselSlider(
                                          items: List.generate(
                                              productsController.productDetails
                                                  .data.productImages.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child:
                                                          CustomFadNetWorkImage(
                                                        imagePath:
                                                            '${productsController.productDetails.data.productImages[index].image}',
                                                        width: media.width,
                                                        boxFit: BoxFit.cover,
                                                        height: 120.0,
                                                      ),
                                                    ),
                                                  )),
                                          options: CarouselOptions(
                                            aspectRatio: 1.5,
                                            viewportFraction: 1.0,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: productsController
                                                        .productDetails
                                                        .data
                                                        .productImages
                                                        .length ==
                                                    1
                                                ? false
                                                : true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: false,
                                            onPageChanged: (int i, test) {
                                              setState(() {
                                                carouselSliderCurrentIndex = i;
                                              });
                                            },
                                            scrollDirection: Axis.horizontal,
                                          )),
                                  productsController.productDetails.data
                                              .productImages.length ==
                                          1
                                      ? SizedBox()
                                      : Container(
                                          height: 35,
                                          width: media.width,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: AnimatedSmoothIndicator(
                                              activeIndex:
                                                  carouselSliderCurrentIndex,
                                              count: productsController
                                                  .productDetails
                                                  .data
                                                  .productImages
                                                  .length,
                                              effect: ExpandingDotsEffect(
                                                activeDotColor:
                                                    Color(0xff3B97D3),
                                                dotColor: Color(0xffDCDCDC),
                                                radius: 7,
                                                spacing: 8,
                                                dotHeight: 4,
                                                dotWidth: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Get the chance to win
                                        //Apple watch G2
                                        Text(
                                          '${productsController.productDetails.data.productDetails.title}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${productsController.productDetails.data.productDetails.price} ${AppLocalizations.of(context).trans('aed')}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //Get the chance to win
                                        //Apple watch G2
                                        Text(
                                          '${productsController.productDetails.data.productDetails.paidCoupons}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '/${productsController.productDetails.data.productDetails.couponsCount} ${AppLocalizations.of(context).trans('coupons')}',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${productsController.productDetails.data.productDetails.days} ${AppLocalizations.of(context).trans('days')}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEA0101)),
                                          ),
                                          Text(
                                            '${productsController.productDetails.data.productDetails.hours} ${AppLocalizations.of(context).trans('hours')}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEA0101)),
                                          ),
                                          Text(
                                            '${productsController.productDetails.data.productDetails.minutes} ${AppLocalizations.of(context).trans('minutes')}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEA0101)),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            bottom: Container(
                              // height: 270,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 15, right: 15),
                                    child: Text(
                                      '${AppLocalizations.of(context).trans('details')}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      '${productsController.productDetails.data.productDetails.description}',
                                      style: cairoW400(
                                              color: Color(0xFF333333),
                                              size: 15)
                                          .copyWith(height: 1.4),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  LocaleStorage.token == null
                                      ? SizedBox()
                                      : productsController.productDetails.data
                                                  .productDetails.quantity ==
                                              0
                                          ? DefaultAppButton(
                                              onPressed: () {
                                                setState(() {
                                                  loader = true;
                                                });
                                                print(productsController
                                                    .productDetails
                                                    .data
                                                    .productDetails
                                                    .quantity);
                                                cartController
                                                    .addToCart(
                                                        context: context,
                                                        productId:
                                                            productsController
                                                                .productDetails
                                                                .data
                                                                .productDetails
                                                                .id,
                                                        quantity: '1')
                                                    .then((value) {
                                                  productsController
                                                      .getUpdatedProductDetails(
                                                          context: context,
                                                          productId:
                                                              productsController
                                                                  .productDetails
                                                                  .data
                                                                  .productDetails
                                                                  .id);
                                                }).then((value) {
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                });
                                              },
                                              text: 'addToCart',
                                            )
                                          : Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: AppLocalizations.of(
                                                                      context)
                                                                  .locale
                                                                  .languageCode ==
                                                              'ar'
                                                          ? 10
                                                          : 0.0,
                                                      left: AppLocalizations.of(
                                                                      context)
                                                                  .locale
                                                                  .languageCode ==
                                                              'ar'
                                                          ? 0
                                                          : 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        loader = true;
                                                      });

                                                      cartController
                                                          .updateCartItem(
                                                              context: context,
                                                              keyOperationValue:
                                                                  '-',
                                                              productId: productsController
                                                                  .productDetails
                                                                  .data
                                                                  .productDetails
                                                                  .cart_row_id)
                                                          .then((value) {
                                                        productsController
                                                            .getUpdatedProductDetails(
                                                                context:
                                                                    context,
                                                                productId: productsController
                                                                    .productDetails
                                                                    .data
                                                                    .productDetails
                                                                    .id);
                                                      }).then((value) {
                                                        setState(() {
                                                          loader = false;
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Center(
                                                          child: Image.asset(
                                                        'images/minus.png',
                                                        color: Colors.grey[500],
                                                      )),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: AppLocalizations.of(
                                                                      context)
                                                                  .locale
                                                                  .languageCode ==
                                                              'ar'
                                                          ? 10
                                                          : 0.0,
                                                      left: AppLocalizations.of(
                                                                      context)
                                                                  .locale
                                                                  .languageCode ==
                                                              'ar'
                                                          ? 0
                                                          : 10),
                                                  child: Container(
                                                    width: 60,
                                                    height: 50,
                                                    child: Center(
                                                        child: Text(
                                                      '${productsController.productDetails.data.productDetails.quantity}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: DefaultAppButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        loader = true;
                                                      });

                                                      cartController
                                                          .updateCartItem(
                                                              context: context,
                                                              keyOperationValue:
                                                                  '+',
                                                              productId: productsController
                                                                  .productDetails
                                                                  .data
                                                                  .productDetails
                                                                  .cart_row_id)
                                                          .then((value) {
                                                        productsController
                                                            .getUpdatedProductDetails(
                                                                context:
                                                                    context,
                                                                productId: productsController
                                                                    .productDetails
                                                                    .data
                                                                    .productDetails
                                                                    .id);
                                                      }).then((value) {
                                                        setState(() {
                                                          loader = false;
                                                        });
                                                      });
                                                    },
                                                    text: 'Add_more',
                                                  ),
                                                ),
                                              ],
                                            ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 10,
                            punchRadius: 10,
                          ),
                        ),
                      ),
              ],
            ),
            loader
                ? Container(
                    width: media.width,
                    height: media.height,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: color1,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
