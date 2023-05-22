import 'package:flutter/material.dart';
import 'package:fursa/Controller/OffersController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class OffersWidget extends StatefulWidget {
  OffersWidget({Key key}) : super(key: key);

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<OffersController>(
      builder: (context, offersController, child) => Container(
        height: 320,
        width: MediaQuery.of(context).size.width,
        child: offersController.offersStage == offersControllerStage.LOADING
            ? Container()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: offersController.offers.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      fadNavigate(
                          context,
                          DealDetails(
                            title: offersController.offers.data[index].title,
                            productId: offersController.offers.data[index].id,
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: media.width - 50,
                      height: media.height / 2.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: standaredBoxShadow),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomFadNetWorkImage(
                                  height: 140.0,
                                  width: double.maxFinite,
                                  boxFit: BoxFit.cover,
                                  imagePath:
                                      '${offersController.offers.data[index].image}',
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Get the chance to win
                                //Apple watch G2
                                Text(
                                  '${offersController.offers.data[index].title}',
                                  style: TextStyle(
                                      fontFamily: 'CairoBold',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${offersController.offers.data[index].price} ${AppLocalizations.of(context).trans('aed')}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${offersController.offers.data[index].paidCoupons}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '/ ${offersController.offers.data[index].couponsCount} ${AppLocalizations.of(context).trans('coupons')}',
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
                                percent: offersController
                                        .offers.data[index].paidCoupons
                                        .toDouble() /
                                    offersController
                                        .offers.data[index].couponsCount
                                        .toDouble(),
                                animation: true,
                                animationDuration: 1200,
                                backgroundColor: Color(0xffD9D9D9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${offersController.offers.data[index].days} ${AppLocalizations.of(context).trans('days')}',
                                      style: TextStyle(
                                          color: Color(0xffEA0101),
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '${offersController.offers.data[index].hours} ${AppLocalizations.of(context).trans('hours')}',
                                      style: TextStyle(
                                          color: Color(0xffEA0101),
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '${offersController.offers.data[index].minutes} ${AppLocalizations.of(context).trans('minutes')}',
                                      style: TextStyle(
                                          color: Color(0xffEA0101),
                                          fontSize: 14),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
