import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SharedComponents/ScreenLoader.dart';
import 'package:fursa/View/SubScreens/UpdateMyProduct/UpdateMyProduct.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyProductsScreen extends StatefulWidget {
  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  void initState() {
    super.initState();

    if (LocaleStorage.token != null) {
      Provider.of<MyProductsController>(context, listen: false)
          .getMyProducts(context: context);
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
    return Consumer2<MyProductsController, ProductsController>(
      builder: (context, myProductsController, productsController, child) =>
          Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: LocaleStorage.token == null
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: color1,
                    title: Text(
                        '${AppLocalizations.of(context).trans('myProducts')}'),
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
            : CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    backgroundColor: color1,
                    title: Text(
                        '${AppLocalizations.of(context).trans('myProducts')}'),
                  ),
                  myProductsController.myProductsStage ==
                          MyProductsControllerStage.LOADING
                      ? ScrreenLoader()
                      : SliverToBoxAdapter(
                          child: myProductsController.myProducts.isEmpty
                              ? Container(
                                  width: media.width,
                                  height: media.height * 0.8,
                                  child: Center(
                                      child: Text(
                                    'لايوجد منتجات حاليا',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                )
                              : Container(
                                  width: media.width,
                                  height: media.height,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 0.75),
                                      itemCount: myProductsController
                                          .myProducts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child:
                                                          CustomFadNetWorkImage(
                                                        width: double.maxFinite,
                                                        height: 120.0,
                                                        boxFit: BoxFit.fill,
                                                        imagePath:
                                                            '${myProductsController.myProducts[index].image}',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              '${myProductsController.myProducts[index].title}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: cairoW600(
                                                                  color: Color(
                                                                      0xFF4D4D4D),
                                                                  size: 12),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      productsController
                                                                          .viewMyProducts(
                                                                              context: context,
                                                                              productId: myProductsController.myProducts[index].id)
                                                                          .then((value) => fadNavigate(context, UpdateMyProduct()));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          '${AppLocalizations.of(context).trans('update')}',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          color:
                                                                              buttonColor1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Alert(
                                                                        context:
                                                                            context,
                                                                        type: AlertType
                                                                            .warning,
                                                                        desc: AppLocalizations.of(context).locale.languageCode ==
                                                                                'en'
                                                                            ? "Do you want to delete the product ?"
                                                                            : "هل تريد حـذف المنتج ؟",
                                                                        buttons: [
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "${AppLocalizations.of(context).trans('ok')}",
                                                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              myProductsController.deleteProduct(
                                                                                context: context,
                                                                                productId: myProductsController.myProducts[index].id,
                                                                              );
                                                                            },
                                                                            width:
                                                                                120,
                                                                          ),
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "${AppLocalizations.of(context).trans('cancel')}",
                                                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            width:
                                                                                120,
                                                                          )
                                                                        ],
                                                                      ).show();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          '${AppLocalizations.of(context).trans('delete')}',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                // Positioned(
                                                //   left: 0.00,
                                                //   child: InkWell(
                                                //     onTap: () {},
                                                //     child: Container(
                                                //       width: 80,
                                                //       height: 40,
                                                //       child: Center(
                                                //           child: Text('حذف',
                                                //               style: TextStyle(
                                                //                 fontWeight:
                                                //                     FontWeight.bold,
                                                //                 color: Colors.white,
                                                //               ))),
                                                //       decoration: BoxDecoration(
                                                //           borderRadius:
                                                //               BorderRadius.only(
                                                //                   bottomRight: Radius
                                                //                       .circular(10),
                                                //                   topLeft:
                                                //                       Radius.circular(
                                                //                           10)),
                                                //           color: Colors.red
                                                //               .withOpacity(0.5)),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
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
