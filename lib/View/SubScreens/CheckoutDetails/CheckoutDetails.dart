import 'package:flutter/material.dart';
import 'package:fursa/Controller/ChecoutController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:provider/provider.dart';

class CheckoutDetailsScreen extends StatefulWidget {
  CheckoutDetailsScreen({Key key}) : super(key: key);

  @override
  State<CheckoutDetailsScreen> createState() => _CheckoutDetailsScreenState();
}

class _CheckoutDetailsScreenState extends State<CheckoutDetailsScreen> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(
      builder: (context, checkoutController, child) => Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: color1,
                  title:
                      AppLocalizations.of(context).locale.languageCode == 'en'
                          ? Text(
                              'Checout',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'الدفع',
                              style: TextStyle(color: Colors.white),
                            ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${AppLocalizations.of(context).trans('total')}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${checkoutController.checkoutDetails.total} ${AppLocalizations.of(context).trans('aed')}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: color1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: List.generate(
                            checkoutController.checkoutDetails.details.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 15) +
                                      const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    height: 140,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: standaredBoxShadow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CustomFadNetWorkImage(
                                            width: 130.0,
                                            height: double.maxFinite,
                                            boxFit: BoxFit.fitHeight,
                                            imagePath: checkoutController
                                                .checkoutDetails
                                                .details[index]
                                                .image,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${checkoutController.checkoutDetails.details[index].title}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              '${checkoutController.checkoutDetails.details[index].price} ${AppLocalizations.of(context).trans('aed')}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: color1),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ' ${AppLocalizations.of(context).trans('count')} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: color1),
                                                  ),
                                                  Text(
                                                    '${checkoutController.checkoutDetails.details[index].quantity}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: color1),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ' ${AppLocalizations.of(context).trans('total')} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: color1),
                                                  ),
                                                  Text(
                                                    '${checkoutController.checkoutDetails.details[index].total} ${AppLocalizations.of(context).trans('aed')}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: color1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              ],
            ),
            loader
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.9,
                    color: Colors.white.withOpacity(0.4),
                    child:
                        Center(child: CircularProgressIndicator(color: color1)))
                : SizedBox()
          ],
        ),
        bottomNavigationBar: Container(
          height: 120,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: DefaultAppButton(
              onPressed: () {
                setState(() {
                  loader = true;
                });
                checkoutController
                    .getMyFatorah(
                        context: context,
                        id: checkoutController.checkoutDetails.id)
                    .then((value) {
                  setState(() {
                    loader = false;
                  });
                });
                // fadNavigate(context, CheckoutDetailsScreen());
              },
              text: 'checkout',
            ),
          ),
        ),
      ),
    );
  }
}
