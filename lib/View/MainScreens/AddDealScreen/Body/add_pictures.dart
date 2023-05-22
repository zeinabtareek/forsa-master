import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';

class AddPictuesTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  final String Function(String) validator;

  AddPictuesTextField({this.controller, this.hintText, @required this.validator});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
          width: media.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: standeredContainerBorderRadius,
            boxShadow: standaredBoxShadow,
            color: Colors.white,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: .5,
                child: Image.asset('images/add_picture.png'),
              ),
              Text(
                '${AppLocalizations.of(context).trans(hintText)}',
                style: TextStyle(color: Color(0xffB3B3B3)),
              ),
            ],
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: TextFormField(
          //     validator: validator,
          //     controller: controller,
          //     readOnly: true,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.only(top: 14),
          //       prefixIcon: Transform.scale(
          //         scale: .5,
          //         child: Image.asset('images/add_picture.png'),
          //       ),
          //       hintText: hintText != null ? '${AppLocalizations.of(context).trans(hintText)}' : '',
          //       hintStyle: TextStyle(color: Color(0xffB3B3B3)),
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
