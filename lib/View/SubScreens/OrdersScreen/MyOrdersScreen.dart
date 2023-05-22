import 'package:flutter/material.dart';
import 'package:fursa/Controller/CartController.dart';
import 'package:fursa/Controller/OrderController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/OrdersScreen/OrderdetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyOrdersScreen extends StatefulWidget {
  MyOrdersScreen({Key key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();

    if (LocaleStorage.token != null) {
      Provider.of<OrderController>(context, listen: false)
          .getOrders(context: context);
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
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Consumer<OrderController>(
      builder: (context, orderController, child) => Scaffold(
        body: LocaleStorage.token == null
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: color1,
                    centerTitle: true,
                    title: Text(
                      '${AppLocalizations.of(context).trans('orders')}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: media.width,
                      height: media.height * 0.8,
                      child: Center(
                          child: Text(
                              '${AppLocalizations.of(context).trans('please_login')}')),
                    ),
                  )
                ],
              )
            : CustomScrollView(slivers: [
                SliverAppBar(
                  backgroundColor: color1,
                  centerTitle: true,
                  title: Text(
                    '${AppLocalizations.of(context).trans('orders')}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                orderController.ordersStage == OrderControllerStage.LOADING
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                    : SliverToBoxAdapter(
                        child: orderController.orders.isEmpty
                            ? Container(
                                width: media.width,
                                height: media.height * 0.8,
                                child: Center(
                                    child: Text(
                                  'لايوجد طلبات حاليا',
                                  style: TextStyle(color: Colors.grey),
                                )),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: List.generate(
                                      orderController.orders.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                    horizontal: 15) +
                                                const EdgeInsets.only(
                                                    bottom: 15),
                                            child: Container(
                                                width: media.width,
                                                height: 170,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow:
                                                        standaredBoxShadow),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'رقم الفاتورة',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                'تاريخ العملية',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                'العدد',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '${orderController.orders[index].serialNumber}'),
                                                              Text(
                                                                  '${orderController.orders[index].operationDate}'),
                                                              Text(
                                                                  '${orderController.orders[index].countItems}')
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          fadNavigate(
                                                              context,
                                                              OrderdetailsScreen(
                                                                orderId:
                                                                    orderController
                                                                        .orders[
                                                                            index]
                                                                        .id,
                                                              ));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width:
                                                              double.maxFinite,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  buttonColor1,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Center(
                                                            child: Text(
                                                              '${AppLocalizations.of(context).trans('details')}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          )),
                                ),
                              ),
                      )
              ]),
      ),
    );
  }
}
