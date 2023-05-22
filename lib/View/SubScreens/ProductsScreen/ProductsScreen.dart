import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<ProductsController>(
      builder: (context, productsController, child) => Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarBack(title: 'latest_products'),
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  productsController.latestProducts.data.length,
                  (index) => InkWell(
                    onTap: () {
                      fadNavigate(
                          context,
                          DealDetails(
                            title: productsController
                                .latestProducts.data[index].title,
                            productId: productsController
                                .latestProducts.data[index].id,
                          ));
                    },
                    child: Container(
                      // width: 100,
                      height: 270,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      padding: EdgeInsets.all(16),
                      decoration: decorationRadius(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomFadNetWorkImage(
                              width: double.maxFinite,
                              height: 120.0,
                              boxFit: BoxFit.cover,
                              imagePath:
                                  '${productsController.latestProducts.data[index].image}',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${productsController.latestProducts.data[index].title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  productsController.latestProducts.data[index]
                                              .avalibale ==
                                          'no'
                                      ? Text(
                                          'Not Available',
                                          style: cairoW800(
                                              color: Color(0xFFDE1E04),
                                              size: 14),
                                        )
                                      : Text(
                                          'Available',
                                          style: cairoW800(
                                              color: Color(0xFF00489A),
                                              size: 14),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${productsController.latestProducts.data[index].paidCoupons}',
                                    style: cairoW700(
                                        size: 12, color: Colors.black),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '/ ${productsController.latestProducts.data[index].couponsCount}',
                                    style: cairoW400(
                                        size: 12, color: Colors.black),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${AppLocalizations.of(context).trans('coupons')}',
                                    style: cairoW400(
                                        size: 12, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 4),
                                child: Container(
                                  child: LinearPercentIndicator(
                                    progressColor: buttonColor1,
                                    percent: productsController.latestProducts
                                                .data[index].paidCoupons !=
                                            null
                                        ? (productsController.latestProducts
                                                .data[index].paidCoupons
                                                .toDouble()) /
                                            productsController.latestProducts
                                                .data[index].couponsCount
                                                .toDouble()
                                        : 0.4,
                                    animation: true,
                                    animationDuration: 1200,
                                    backgroundColor: Color(0xffD9D9D9),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${productsController.latestProducts.data[index].days} ${AppLocalizations.of(context).trans('days')}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffEA0101)),
                                      ),
                                      Text(
                                        '${productsController.latestProducts.data[index].hours} ${AppLocalizations.of(context).trans('hours')}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffEA0101)),
                                      ),
                                      Text(
                                        '${productsController.latestProducts.data[index].minutes} ${AppLocalizations.of(context).trans('minutes')}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffEA0101)),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// child: Column(
//   children: [
//     SizedBox(height: 20),
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Container(
//         width: media.width,
//         height: 90,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                   width: 50,
//                   height: 50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Image.asset(
//                       'images/cards.png',
//                       width: 10,
//                     ),
//                   ),
//                   decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffF7F7F7))),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Ahmed Saad El Din',
//                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       '1584 **** **** ****',
//                       style: TextStyle(
//                         color: Color(0xff91989D),
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     Text(
//                       '12/23',
//                       style: TextStyle(
//                         color: Color(0xff91989D),
//                         fontWeight: FontWeight.normal,
//                       ),
//                     )
//                     //12/23
//                   ],
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   Container(
//                       width: 50,
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'images/trash.png',
//                           width: 10,
//                         ),
//                       ),
//                       decoration:
//                           BoxDecoration(shape: BoxShape.circle, color: Color(0xffF7F7F7))),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                       width: 50,
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'images/edit.png',
//                           width: 10,
//                         ),
//                       ),
//                       decoration:
//                           BoxDecoration(shape: BoxShape.circle, color: Color(0xffF7F7F7)))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//     Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
//         child: InkWell(
//           onTap: () {
//             fadNavigate(context, AddPaymentCard());
//           },
//           child: Row(
//             children: [
//               Container(
//                 width: 20,
//                 height: 20,
//                 child: Center(
//                   child: Icon(
//                     Icons.add,
//                     size: 15,
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(color: Color(0xff292D32))),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Add New card',
//                 style: TextStyle(color: Color(0xff292D32), fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ),
//       ),
//     )
//   ],
// ),
