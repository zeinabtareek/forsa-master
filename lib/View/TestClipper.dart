import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = ''}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.pink[400],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(widget.title),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Ticket(
            top: Container(
              height: 250,
            ),
            bottom: Container(
              height: 200,
            ),
            width: MediaQuery.of(context).size.width,
            borderRadius: 10,
            punchRadius: 10,
          ),
        )));
  }
}

class Ticket extends StatefulWidget {
  final double width;
  final EdgeInsets padding;
  final double punchRadius;
  final double borderRadius;

  // final double height;
  // final Widget child;
  final Widget top;
  final Widget bottom;
  final Color color;
  final bool isCornerRounded;

  Ticket(
      {@required this.width,
      // @required this.height,
      // @required this.child,
      @required this.top,
      @required this.bottom,
      @required this.borderRadius,
      @required this.punchRadius,
      this.padding = const EdgeInsets.all(5.0),
      this.color = Colors.white,
      this.isCornerRounded = false});

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      // color: Colors.transparent,
      // elevation: 0,
      child: Container(
        padding: widget.padding,
        decoration: new BoxDecoration(
            // color: Colors.transparent,
            boxShadow: [
              new BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 20,
                offset: new Offset(0.0, 0.0),
              ),
              new BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 20,
                  offset: new Offset(0.0, 10.0),
                  spreadRadius: -15)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipPath(
              clipper: TicketClipper(widget.punchRadius),
              child: Column(
                children: <Widget>[
                  Container(
                    // duration: Duration(seconds: 1),
                    width: widget.width,
                    // minHeight: widget.height,
                    child: widget.top,
                    decoration: BoxDecoration(
                        color: widget.color, borderRadius: BorderRadius.circular(widget.borderRadius)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: widget.width,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        child: Divider(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CustomPaint(painter: MyLinePainter()),
            ClipPath(
              clipper: TicketClipperBottom(widget.punchRadius),
              child: Container(
                // duration: Duration(seconds: 1),
                width: widget.width,

                child: widget.bottom,
                decoration: BoxDecoration(
                    color: widget.color, borderRadius: BorderRadius.circular(widget.borderRadius)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  double punchRadius;

  TicketClipper(this.punchRadius);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(0.0, size.height), radius: punchRadius));
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height), radius: punchRadius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TicketClipperBottom extends CustomClipper<Path> {
  double punchRadius;

  TicketClipperBottom(this.punchRadius);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(0.0, 0), radius: punchRadius));
    path.addOval(Rect.fromCircle(center: Offset(size.width, 0), radius: punchRadius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Dash extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const Dash({this.height = 1, this.width = 3, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
