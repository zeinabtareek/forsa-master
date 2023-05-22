import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:provider/provider.dart';

class AppBarBack extends StatelessWidget {
  const AppBarBack({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: color1,
      title: Text('${AppLocalizations.of(context).trans(title)}', style: cairoW400()),
      centerTitle: true,
      toolbarHeight: 74,
      pinned: true,
      leading: Provider.of<LocalizationController>(context, listen: false).locale.languageCode == 'en'
          ? InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                child: Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Color(0xFF195AA4), shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      'images/arrow_left.png',
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      actions: [
        Provider.of<LocalizationController>(context, listen: false).locale.languageCode == 'en'
            ? const SizedBox()
            : InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                  child: Container(
                    width: 46,
                    height: 46,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Color(0xFF195AA4), shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset(
                        'images/arrow_left.png',
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
