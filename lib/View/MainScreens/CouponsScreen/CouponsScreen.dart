import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Core/Constnts.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';

class CouponsScreen extends StatefulWidget {
  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarHome(title: 'Coupons'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.only(
                              left: defaultPading,
                              right: defaultPading,
                              bottom: 10,
                            ),
                            child: Container(
                              width: media.width,
                              height: 110,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: standaredBoxShadow,
                                borderRadius: BorderRadius.circular(defaultPading),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Apple watch G2',
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Closing in 16 : 55 : 45',
                                        style: TextStyle(color: Color(0xffEA0101)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Code : GTR 5487 - 2548'),
                                    ],
                                  ),
                                  Text(
                                    '50 AED',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xff00489A)),
                                  )
                                ],
                              ),
                            ),
                          ))),
            ),
          )
        ],
      ),
    );
  }
}
