import 'package:flutter/material.dart';

import '../../Core/Styles/Colors.dart';

var defaultGregientContainer = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [color1, color2],
    tileMode: TileMode.clamp,
  ),
);

List<BoxShadow> standaredBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  ),
];

BorderRadius standeredContainerBorderRadius = BorderRadius.circular(16);
var defaultGregientContainerButton = BoxDecoration(
    borderRadius: standeredContainerBorderRadius,
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [buttonColor1, buttonColor2],
        tileMode: TileMode.clamp));
