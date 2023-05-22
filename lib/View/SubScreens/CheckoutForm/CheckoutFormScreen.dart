import 'package:flutter/material.dart';
import 'package:fursa/Controller/ChecoutController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Models/SettingsModel.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/CheckoutDetails/CheckoutDetails.dart';
import 'package:provider/provider.dart';

class CheckOutFormScreen extends StatefulWidget {
  CheckOutFormScreen({Key key}) : super(key: key);

  @override
  State<CheckOutFormScreen> createState() => _CheckOutFormScreenState();
}

class _CheckOutFormScreenState extends State<CheckOutFormScreen> {
  var checoutProvider;
  bool loader = false;
  int cityId;
  @override
  void initState() {
    super.initState();
    checoutProvider = Provider.of<CheckoutController>(context, listen: false);
    Provider.of<CheckoutController>(context, listen: false)
        .checkoutUserName
        .text = LocaleStorage.userName;
    Provider.of<CheckoutController>(context, listen: false)
        .checkoutUserMobile
        .text = LocaleStorage.userPhone;
    Provider.of<CheckoutController>(context, listen: false)
        .checkoutUserEmail
        .text = LocaleStorage.userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CheckoutController, SettingsController>(
      builder: (context, checoutController, settingsController, child) =>
          Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
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
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: standaredBoxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: checoutController.checkoutUserName,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: standaredBoxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: checoutController.checkoutUserEmail,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: standaredBoxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: checoutController.checkoutUserMobile,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: standaredBoxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'العنوان'),
                              controller: checoutController.checkoutUserAddress,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: standaredBoxShadow,
                            color: Colors.white,
                          ),
                          child: DropdownButtonFormField<Cities>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.only(
                                  start: 16,
                                  end: 8,
                                  bottom: 4,
                                ),
                              ),
                              isDense: false,
                              itemHeight: 55,
                              dropdownColor: Colors.white,
                              // iconEnabledColor: Color(0xFF374957),
                              icon: Image.asset(
                                'images/arrow_down_list.png',
                                width: 30,
                                height: 30,
                              ),
                              hint: Text('اختر  المدينة'),
                              iconDisabledColor: Color(0xFF374957),
                              // value: selectedSubCat,
                              items: settingsController.settings.cities
                                  .map(
                                    (item) => DropdownMenuItem<Cities>(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Color(0xffB3B3B3),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (Cities item) {
                                setState(() {
                                  cityId = item.id;
                                });
                                checoutController.setCityId(item.id);
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: standaredBoxShadow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'كوبون الخصم'),
                                controller:
                                    checoutController.checkoutUsercoupoune,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: loader
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                color: Colors.white.withOpacity(0.4),
                child: Center(child: CircularProgressIndicator(color: color1)))
            : DefaultAppButton(
                onPressed: () {
                  if (checoutController.checkoutUserAddress.text.isNotEmpty &&
                      cityId != null) {
                    setState(() {
                      loader = true;
                    });
                    checoutController.checkout(context: context).then((value) {
                      setState(() {
                        loader = false;
                      });
                      fadNavigate(context, CheckoutDetailsScreen());
                    });
                  } else {
                    if (cityId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: AppLocalizations.of(context)
                                    .locale
                                    .languageCode ==
                                'ar'
                            ? Text('برجاء اختيار المدينة',
                                style: TextStyle(
                                    fontFamily: 'NotoKufiArabic-Light',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                            : Text('Please select a city',
                                style: TextStyle(
                                    fontFamily: 'NotoKufiArabic-Light',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ));
                    } else if (checoutController
                        .checkoutUserAddress.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: AppLocalizations.of(context)
                                    .locale
                                    .languageCode ==
                                'ar'
                            ? Text('برجاء اضافة العنوان',
                                style: TextStyle(
                                    fontFamily: 'NotoKufiArabic-Light',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                'Please add the address',
                                style: TextStyle(
                                    fontFamily: 'NotoKufiArabic-Light',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      ));
                    }
                  }
                  // fadNavigate(context, CheckoutDetailsScreen());
                },
                text: 'checkout',
              ),
      ),
    );
  }
}
