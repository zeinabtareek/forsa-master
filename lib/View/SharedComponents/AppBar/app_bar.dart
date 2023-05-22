import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: color1,
      title: Text('${AppLocalizations.of(context).trans(title)}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      centerTitle: true,
      toolbarHeight: 74,
      pinned: true,
      leading: const SizedBox(),
    );
  }
}
