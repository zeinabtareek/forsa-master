import 'package:flutter/material.dart';
import 'package:fursa/Controller/pageIndexController.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:provider/provider.dart';

class OrderDoneScreen extends StatefulWidget {
  @override
  State<OrderDoneScreen> createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarBack(title: 'orderDone'),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'images/orderDone.png',
                    width: 200,
                  ),
                  Text(
                    'Good Luck in The Draw',
                    style: TextStyle(color: Color(0xff00489A), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Your coupon number is
                  Text(
                    'Your coupon number is ',
                    style: TextStyle(color: Color(0xff4D4D4D), fontWeight: FontWeight.normal, fontSize: 16),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'GTR 2548-5847',
                    style: TextStyle(color: Color(0xff00489A), fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  DefaultAppButton(
                    onPressed: () {
                      Provider.of<PageIndexController>(context, listen: false)
                          .changeIndexFunctionWithOutNotify(0);
                      fadNavigate(context, NavigationHomeScreen());
                    },
                    text: 'backToDeals',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
