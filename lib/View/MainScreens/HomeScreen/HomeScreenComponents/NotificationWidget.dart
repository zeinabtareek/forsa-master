import 'package:flutter/material.dart';
import 'package:fursa/Core/Styles/Colors.dart';

class NotificationWidget extends StatelessWidget {
  Function onPressed;

  NotificationWidget({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 40,
        padding: EdgeInsets.all(8),
        margin: EdgeInsetsDirectional.only(end: 10, top: 16, bottom: 16),
        decoration: BoxDecoration(color: color2, shape: BoxShape.circle),
        child: Image.asset(
          'images/notification.png',
          width: 25,
        ),
      ),
    );
  }
}
