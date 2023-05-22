import 'package:flutter/material.dart';

BoxDecoration decorationRadius({Color color = Colors.white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        offset: const Offset(0, 0),
        blurRadius: 4.0,
      )
    ],
  );
}

BoxDecoration decorationRadiusBorder({
  Color color = Colors.white,
  Color borderColor = Colors.white,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: borderColor),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        offset: const Offset(0, 0),
        blurRadius: 4.0,
      )
    ],
  );
}
