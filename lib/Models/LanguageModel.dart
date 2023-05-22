import 'package:flutter/material.dart';

class LanguageModel {
  dynamic id;
  dynamic name;
  dynamic code;
  bool isSelected = false;

  LanguageModel({
    @required this.id,
    @required this.code,
    @required this.name,
    this.isSelected,
  });
}
