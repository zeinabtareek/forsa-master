import 'package:flutter/material.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController message = TextEditingController();
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<SettingsController>(
      builder: (context, settingsController, child) => Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarBack(title: 'contact_us'),
            SliverToBoxAdapter(
              child: Container(
                color: color1,
                width: media.width,
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Text(
                  '${AppLocalizations.of(context).trans('weWillBeHappy')}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: cairoW600(size: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Container(
                    width: media.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((16)),
                      color: Colors.white,
                      boxShadow: standaredBoxShadow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              '${AppLocalizations.of(context).trans('typeYourMessage')}',
                          hintStyle: cairoW400(color: Color(0xFF808080)),
                        ),
                      ),
                    ),
                  ),
                ),
                loader
                    ? Center(
                        child: CircularProgressIndicator(
                          color: color1,
                        ),
                      )
                    : DefaultAppButton(
                        text: 'send',
                        onPressed: () {
                          setState(() {
                            loader = true;
                          });
                          settingsController
                              .contactUs(
                                  context: context, message: message.text)
                              .then((_) {
                            setState(() {
                              loader = false;
                            });
                          });
                        },
                      )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
