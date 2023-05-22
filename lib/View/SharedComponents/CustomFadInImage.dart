import 'package:flutter/material.dart';

class CustomFadNetWorkImage extends StatefulWidget {
  final imagePath;
  final BoxFit boxFit;
  final width;
  final height;

  const CustomFadNetWorkImage({
    this.imagePath,
    this.boxFit,
    @required this.width,
    @required this.height,
  });
  @override
  State<CustomFadNetWorkImage> createState() => _CustomFadNetWorkImageState();
}

class _CustomFadNetWorkImageState extends State<CustomFadNetWorkImage> {
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage("${widget.imagePath}"),
      width: widget.width,
      height: widget.height,
      placeholder: AssetImage(
        "images/logo.png",
      ),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'images/logo.png',
          fit: BoxFit.fill,
          width: widget.width,
          height: widget.height,
        );
      },
      fit: widget.boxFit,
    );
  }
}
