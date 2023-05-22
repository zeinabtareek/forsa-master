import 'package:flutter/material.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:fursa/View/SubScreens/ProductsScreen/ProductsScreen.dart';
import 'package:provider/provider.dart';

class LatestProductWidget extends StatefulWidget {
  LatestProductWidget({Key key}) : super(key: key);

  @override
  State<LatestProductWidget> createState() => _LatestProductWidgetState();
}

class _LatestProductWidgetState extends State<LatestProductWidget> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<ProductsController>(
      builder: (context, productsController, child) => InkWell(
        onTap: () {},
        child: Container(
          height: 270,
          width: media.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).trans('latest_products')}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          fadNavigate(context, ProductsScreen());
                        },
                        child: Text(
                          '${AppLocalizations.of(context).trans('all')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(
                        productsController.latestProducts != null
                            ? productsController.latestProducts.data.length
                            : 0,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
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
                                  decoration: BoxDecoration(
                                    boxShadow: standaredBoxShadow,
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  width: 180,
                                  height: 230,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: CustomFadNetWorkImage(
                                            width: 180.0,
                                            height: 145.0,
                                            boxFit: BoxFit.fill,
                                            imagePath:
                                                '${productsController.latestProducts.data[index].image}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${productsController.latestProducts.data[index].title}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${productsController.latestProducts.data[index].price} ${AppLocalizations.of(context).trans('aed')}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: buttonColor1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
