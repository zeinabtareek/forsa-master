import 'package:flutter/material.dart';
import 'package:fursa/Controller/CartController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/AddPaymentCard/AddPaymentCard.dart';
import 'package:fursa/View/SubScreens/CheckoutForm/CheckoutFormScreen.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:fursa/View/SubScreens/checkOutScreen.dart/checkOutScreen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    if (LocaleStorage.token != null) {
      Provider.of<CartController>(context, listen: false)
          .getCartList(context: context);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Alert(
          context: context,
          type: AlertType.warning,
          desc: "${AppLocalizations.of(context).trans('please_login')} ",
          buttons: [
            DialogButton(
              child: Text(
                "${AppLocalizations.of(context).trans('login')}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    ScaleRoute(page: LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              width: 120,
            )
          ],
        ).show();
      });
    }
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<CartController>(
      builder: (context, cartController, child) => Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color(0xffE5E5E5),
        body: Stack(
          children: [
            LocaleStorage.token == null
                ? CustomScrollView(
                    slivers: [
                      AppBarHome(title: 'cart'),
                      SliverToBoxAdapter(
                        child: Container(
                          width: media.width,
                          height: media.height * 0.75,
                          child: Center(
                              child: Text(
                                  '${AppLocalizations.of(context).trans('please_login')}')),
                        ),
                      )
                    ],
                  )
                : CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      AppBarHome(title: 'cart'),
                      cartController.cartStage == CartControllerStage.LOADING
                          ? SliverToBoxAdapter(
                              child: Container(
                              width: media.width,
                              height: media.height * 0.9,
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
                          : SliverToBoxAdapter(
                              child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: cartController.cartList.isEmpty
                                        ? Container(
                                            height: media.height * 0.7,
                                            child: Center(
                                                child: AppLocalizations.of(
                                                                context)
                                                            .locale
                                                            .languageCode ==
                                                        'ar'
                                                    ? Text('العربة فارغة')
                                                    : Text('Cart is Empty')),
                                          )
                                        : Column(
                                            children: List.generate(
                                                cartController.cartList.length,
                                                (index) => Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 10),
                                                          child: Stack(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  fadNavigate(
                                                                      context,
                                                                      DealDetails(
                                                                        productId: cartController
                                                                            .cartList[index]
                                                                            .productId,
                                                                        title: cartController
                                                                            .cartList[index]
                                                                            .title,
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: media
                                                                      .width,
                                                                  height: media
                                                                          .height /
                                                                      5.5,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      boxShadow:
                                                                          standaredBoxShadow),
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          child:
                                                                              CustomFadNetWorkImage(
                                                                            boxFit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                double.maxFinite,
                                                                            width:
                                                                                100.0,
                                                                            imagePath:
                                                                                '${cartController.cartList[index].image}',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 0.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              '${cartController.cartList[index].title}',
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Color(0xff4D4D4D), fontSize: 12, fontWeight: FontWeight.w600),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            //50 AED
                                                                            Text(
                                                                              '${cartController.cartList[index].total} ${AppLocalizations.of(context).trans('aed')}',
                                                                              style: TextStyle(color: Color(0xff00489A), fontSize: 14, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: AppLocalizations.of(
                                                                          context)
                                                                      .locale
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 30.0
                                                              : null,
                                                          left: AppLocalizations.of(
                                                                          context)
                                                                      .locale
                                                                      .languageCode ==
                                                                  'en'
                                                              ? null
                                                              : 30,
                                                          bottom: 20,
                                                          child: Container(
                                                              width: 100,
                                                              height: 35,
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              color1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (cartController
                                                                              .cartList[index]
                                                                              .quantity !=
                                                                          0) {
                                                                        setState(
                                                                            () {
                                                                          cartController
                                                                              .cartList[index]
                                                                              .quantity--;
                                                                        });
                                                                        cartController.updateCartItem(
                                                                            context:
                                                                                context,
                                                                            productId:
                                                                                cartController.cartList[index].id,
                                                                            keyOperationValue: '-');
                                                                      } else {}
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      'images/minus.png',
                                                                      width: 20,
                                                                      color:
                                                                          color1,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${cartController.cartList[index].quantity}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        cartController
                                                                            .cartList[index]
                                                                            .quantity++;
                                                                      });
                                                                      cartController.updateCartItem(
                                                                          context:
                                                                              context,
                                                                          productId: cartController
                                                                              .cartList[
                                                                                  index]
                                                                              .id,
                                                                          keyOperationValue:
                                                                              '+');
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      'images/add.png',
                                                                      width: 20,
                                                                      color:
                                                                          color1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Positioned(
                                                            right: AppLocalizations.of(
                                                                            context)
                                                                        .locale
                                                                        .languageCode ==
                                                                    'en'
                                                                ? 30.0
                                                                : null,
                                                            left: AppLocalizations.of(
                                                                            context)
                                                                        .locale
                                                                        .languageCode ==
                                                                    'en'
                                                                ? null
                                                                : 30,
                                                            top: 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                cartController
                                                                    .removeFromCart(
                                                                        scaffoldkey:
                                                                            _scaffoldkey,
                                                                        context:
                                                                            context,
                                                                        index:
                                                                            index,
                                                                        cartId: cartController
                                                                            .cartList[
                                                                                index]
                                                                            .id)
                                                                    .then(
                                                                        (value) {
                                                                  cartController
                                                                      .getUpdatedCartList(
                                                                          context:
                                                                              context);
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .red
                                                                        .withOpacity(
                                                                            0.5)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))
                                                      ],
                                                    )),
                                          ),
                                  ),
                                ],
                              ),
                            )),
                      SliverToBoxAdapter(
                          child: const SizedBox(
                        height: 150,
                      ))
                    ],
                  ),
            cartController.cartStage == CartControllerStage.LOADING
                ? SizedBox()
                : cartController.cartList != null &&
                        cartController.cartList.isEmpty
                    ? SizedBox()
                    : Positioned(
                        bottom: 100.0,
                        right: 0.0,
                        left: 0.0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DefaultAppButton(
                            onPressed: () {
                              fadNavigate(context, CheckOutFormScreen());
                            },
                            text: 'checkout',
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
