import 'package:flutter/material.dart';
import 'package:fursa/Core/Constnts.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/DrawDetails/DrawDetails.dart';

class DrawScreen extends StatefulWidget {
  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarHome(title: 'Draw'),
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
                    child: InkWell(
                      onTap: () {
                        fadNavigate(context, DrawDetails());
                      },
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apple watch G2',
                                  style: TextStyle(
                                      color: Color(0xff4D4D4D), fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Congratulations',
                                  style: TextStyle(color: Color(0xff666666)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Code : GTR 5487 - 2548'),
                              ],
                            ),
                            Text(
                              'Winner',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff00489A)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
