import 'package:flutter/material.dart';

void showSnack(
    {msg,
    BuildContext context,
    var scaffoldKey,
    fullHeight,
    marginBottom,
    isFloating = false,
    Color color}) {
  var _snackBar = SnackBar(
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      backgroundColor: color ?? Color(0xffff1e1e).withOpacity(0.7),
      margin: EdgeInsets.fromLTRB(4, 0, 4, marginBottom ?? 5),
      content: Container(
        height: fullHeight ?? 89,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "$msg",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CairoSemiBold',
                  fontSize: 13),
              maxLines: 1,
            )),
            fullHeight == null
                ? SizedBox(
                    height: 60.0,
                  )
                : SizedBox()
          ],
        ),
      ));

  scaffoldKey.currentState.showSnackBar(_snackBar);
}
