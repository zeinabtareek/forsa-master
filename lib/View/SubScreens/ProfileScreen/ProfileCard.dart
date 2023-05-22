import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({this.image, this.title});

  final image;
  final title;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: Container(
        width: media.width,
        height: media.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: standaredBoxShadow,
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Transform.scale(
                scale: 0.7,
                child: Image.asset(
                  '$image',
                  width: 35,
                  height: 35,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              '${AppLocalizations.of(context).trans(title)}',
              style: cairoW400(color: Color(0xFF4D4D4D)),
            ),
            Spacer(),
            Provider.of<LocalizationController>(context, listen: false)
                        .locale
                        .languageCode ==
                    'en'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset(
                        'images/arrow-right.png',
                        width: 30,
                        height: 30,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset(
                        'images/arrow-right-ar.png',
                        width: 30,
                        height: 30,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
