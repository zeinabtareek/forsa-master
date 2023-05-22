import 'package:flutter/material.dart';
import 'package:fursa/Controller/OrderController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

class OrderdetailsScreen extends StatefulWidget {
  OrderdetailsScreen({Key key, this.orderId}) : super(key: key);
  final orderId;
  @override
  State<OrderdetailsScreen> createState() => _OrderdetailsScreenState();
}

class _OrderdetailsScreenState extends State<OrderdetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderController>(context, listen: false)
        .getOrderDetails(context: context, orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Consumer<OrderController>(
      builder: (context, orderController, child) => Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: color1,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: List.generate(
                          orderController.orderDetails.data.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15) +
                                        const EdgeInsets.only(bottom: 15),
                                child: Container(
                                    width: media.width,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: standaredBoxShadow),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'المنتج',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'العدد',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'المجموع الجزئي',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'المجموع',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${orderController.orderDetails.data[index].productDetails.title}'),
                                                  Text(
                                                      '${orderController.orderDetails.data[index].productDetails.quantity}'),
                                                  Text(
                                                      '${orderController.orderDetails.data[index].productDetails.price}'),
                                                  Text(
                                                      '${orderController.orderDetails.data[index].productDetails.total}'),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
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
