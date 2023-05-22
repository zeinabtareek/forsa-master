import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';

class DescriptionTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  final String Function(String) validator;

  DescriptionTextField({this.controller, this.hintText, @required this.validator});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        width: media.width,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: standeredContainerBorderRadius,
          boxShadow: standaredBoxShadow,
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText != null ? '${AppLocalizations.of(context).trans(hintText)}' : '',
              hintStyle: TextStyle(color: Color(0xffB3B3B3)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
