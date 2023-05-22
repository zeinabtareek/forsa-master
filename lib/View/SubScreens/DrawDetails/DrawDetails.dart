import 'package:flutter/material.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DrawDetails extends StatefulWidget {
  @override
  State<DrawDetails> createState() => _DrawDetailsState();
}

class _DrawDetailsState extends State<DrawDetails> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarBack(title: 'DrawDetails'),
          SliverToBoxAdapter(
            child: Column(
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.all(20),
                  width: media.width,
                  height: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: standaredBoxShadow),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('images/jeep2.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Get the chance to win
                            //Apple watch G2
                            Text(
                              'Jeep Wrangler',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '200 AED',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Get the chance to win
                            //Apple watch G2
                            Text(
                              '150',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '/100 Coupons',
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Container(
                          child: LinearPercentIndicator(
                            progressColor: buttonColor1,
                            percent: 0.35,
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
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '90 Days',
                                style: TextStyle(color: Color(0xffEA0101)),
                              ),
                              Text(
                                '23 Hours',
                                style: TextStyle(color: Color(0xffEA0101)),
                              ),
                              Text(
                                '45 Seconds',
                                style: TextStyle(color: Color(0xffEA0101)),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultAppButton(
                        text: 'addToCart',
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
