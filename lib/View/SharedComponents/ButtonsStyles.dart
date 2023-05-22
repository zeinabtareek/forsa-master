import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';

class DefaultAppButton extends StatelessWidget {
  final onPressed;
  final text;

  DefaultAppButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: media.width,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFCF24),
              Color(0xFFE6AC1D),
            ],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Center(
          child: Text(
            '${AppLocalizations.of(context).trans('$text')}',
            style: cairoW800(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
