import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:provider/provider.dart';

import '../NavigationControl.dart';

void logoutDialog({BuildContext context}) {
  showAnimatedDialog(
    context,
    RotatedRDialog(
      Container(
        width: 380,
        // height: 280.h,
        padding: EdgeInsets.all(16),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context).trans('sureLogOut')}',
              style: cairoW500(color: Colors.black),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 110,
                    height: 50,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: 110,
                          height: 50,
                          child: Center(
                            child: Text(
                              '${AppLocalizations.of(context).trans('cancel')}',
                              style: cairoW700(color: const Color(0xFFECA436)),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFCF24),
                            Color(0xFFE6AC1D),
                          ],
                        ),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<AuthController>(context, listen: false)
                        .logout(context: context);
                  },
                  child: Container(
                      width: 110,
                      height: 50,
                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFCF24),
                              Color(0xFFE6AC1D),
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                          borderRadius: BorderRadiusDirectional.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '${AppLocalizations.of(context).trans('confirm')}',
                            style: cairoW700(color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),
    isFlip: true,
  );
}

class RotatedRDialog extends StatelessWidget {
  final child;

  RotatedRDialog(this.child);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [Expanded(child: child)])
      ]),
    );
  }
}

void showAnimatedDialog(BuildContext context, Widget dialog,
    {bool isFlip = false, bool dismissible = true}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation1, animation2) => dialog,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, a1, a2, widget) {
      if (isFlip) {
        return Rotation3DTransition(
          alignment: Alignment.center,
          turns: Tween<double>(begin: math.pi, end: 2.0 * math.pi).animate(
              CurvedAnimation(
                  parent: a1,
                  curve: const Interval(0.0, 1.0, curve: Curves.linear))),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: a1,
                    curve: const Interval(0.5, 1.0, curve: Curves.elasticOut))),
            child: widget,
          ),
        );
      } else {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      }
    },
  );
}

class Rotation3DTransition extends AnimatedWidget {
  Rotation3DTransition({
    Key key,
    Animation<dynamic> turns,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(turns != null),
        super(key: key, listenable: turns);

  dynamic get turns => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0006)
      ..rotateY(turnsValue);
    return Transform(
      transform: transform,
      alignment: const FractionalOffset(0.5, 0.5),
      child: child,
    );
  }
}
