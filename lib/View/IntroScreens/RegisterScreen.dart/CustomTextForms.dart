import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';

class RegisterTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  final String Function(String) validator;

  RegisterTextField({this.controller, this.hintText, @required this.validator});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        width: media.width,
        height: 50,
        decoration: decorationRadius(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText != null ? '${AppLocalizations.of(context).trans(hintText)}' : '',
              hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
