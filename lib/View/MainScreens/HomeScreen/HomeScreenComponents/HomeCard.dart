import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Models/SliderModel.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DealDetails/DealDetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeCard extends StatelessWidget {
  var slider;
  HomeCard(this.slider);
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        fadNavigate(
            context,
            DealDetails(
              productId: slider.id,
              title: slider.title,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        width: media.width,
        height: media.height / 1.7,
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
                borderRadius: BorderRadius.circular(16),
                child: CustomFadNetWorkImage(
                  width: media.width,
                  boxFit: BoxFit.cover,
                  height: 120.0,
                  imagePath: '${slider.image}',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Get the chance to win
                  //Apple watch G2
                  Text(
                    '${slider.title}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${slider.price} ${AppLocalizations.of(context).trans('aed')}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Get the chance to win
                  //Apple watch G2
                  Text(
                    '${slider.paidCoupons}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '/${slider.couponsCount} ${AppLocalizations.of(context).trans('coupons')}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${slider.days} ${AppLocalizations.of(context).trans('days')}',
                        style:
                            TextStyle(color: Color(0xffEA0101), fontSize: 14),
                      ),
                      Text(
                        '${slider.hours} ${AppLocalizations.of(context).trans('hours')}',
                        style:
                            TextStyle(color: Color(0xffEA0101), fontSize: 14),
                      ),
                      Text(
                        '${slider.minutes} ${AppLocalizations.of(context).trans('minutes')}',
                        style:
                            TextStyle(color: Color(0xffEA0101), fontSize: 14),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
