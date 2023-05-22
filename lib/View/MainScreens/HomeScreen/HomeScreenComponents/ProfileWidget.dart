import 'package:flutter/material.dart';
import 'package:fursa/Core/Styles/Colors.dart';

class ProfileWdget extends StatelessWidget {
  Function onPressed;

  ProfileWdget({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        padding: EdgeInsets.all(8),
        margin: EdgeInsetsDirectional.only(start: 10, top: 16, bottom: 16),
        decoration: BoxDecoration(color: color2, shape: BoxShape.circle),
        child: Image.asset(
          'images/profile.png',
          width: 25,
        ),
      ),
    );
  }
}
