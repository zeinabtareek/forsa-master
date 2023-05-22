import 'package:flutter/material.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScrreenLoader extends StatelessWidget {
  const ScrreenLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Container(
        width: media.width,
        height: media.height,
        child: Center(
            child: LoadingAnimationWidget.dotsTriangle(
          color: buttonColor1,
          size: 50,
        )),
      ),
    );
  }
}
