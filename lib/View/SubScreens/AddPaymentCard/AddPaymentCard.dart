import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/OrderDoneScreen.dart/OrderDoneScreen.dart';

class AddPaymentCard extends StatefulWidget {
  @override
  State<AddPaymentCard> createState() => _AddPaymentCardState();
}

class _AddPaymentCardState extends State<AddPaymentCard> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarBack(title: 'checkout'),
          SliverToBoxAdapter(
            child: Container(
              width: media.width,
              height: media.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Container(
                      width: media.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: standaredBoxShadow,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${AppLocalizations.of(context).trans('name')}',
                          hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Container(
                      width: media.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: standaredBoxShadow,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '${AppLocalizations.of(context).trans('cardNumber')}',
                          hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: standaredBoxShadow,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'MM/YY',
                                  hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: standaredBoxShadow,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'CVV',
                                  hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  DefaultAppButton(
                    text: 'confirmOrder',
                    onPressed: () {
                      fadNavigate(context, OrderDoneScreen());
                    },
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
