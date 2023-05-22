import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/AddPaymentCard/AddPaymentCard.dart';
import 'package:fursa/View/SubScreens/OrderDoneScreen.dart/OrderDoneScreen.dart';
import 'package:fursa/View/TestClipper.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarBack(title: 'checkout'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Ticket(
                top: Container(
                  height: 300,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/visa.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: InkWell(
                            onTap: () {
                              fadNavigate(context, AddPaymentCard());
                            },
                            child: Row(
                              children: [
                                Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[600])),
                                    child: Image.asset('images/add.png',
                                        width: 12, color: Colors.grey[600])),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Add card',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Payment Summary',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Apple watch G2',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '50 AED',
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
                              horizontal: 15, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VAT',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '50 AED',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottom: Container(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand total',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '55 AED',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                borderRadius: 10,
                punchRadius: 10,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: DefaultAppButton(
            onPressed: () {
              fadNavigate(context, OrderDoneScreen());
              // fadNavigate(context, CheckoutDetailsScreen());
            },
            text: 'checkout',
          ),
        ),
      ),
    );
  }
}
