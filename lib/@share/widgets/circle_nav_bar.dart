library circle_nav_bar;

import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/material.dart';

class CircleNavBar extends StatefulWidget {
  const CircleNavBar({
    super.key,
    required this.activeIndex,
    this.onTap,
    this.tabCurve = Curves.linearToEaseOut,
    this.iconCurve = Curves.bounceOut,
    this.tabDurationMillSec = 1000,
    this.iconDurationMillSec = 500,
    required this.activeIcons,
    required this.inactiveIcons,
    required this.height,
    required this.circleWidth,
    required this.color,
    this.circleColor,
    this.padding = EdgeInsets.zero,
    this.cornerRadius = BorderRadius.zero,
    this.shadowColor = Colors.white,
    this.circleShadowColor,
    this.elevation = 0,
    this.gradient,
    this.circleGradient,
    required this.textActive,
  })  : assert(circleWidth <= height, 'circleWidth <= height'),
        assert(activeIcons.length == inactiveIcons.length,
            'activeIcons.length and inactiveIcons.length must be equal!'),
        assert(activeIcons.length > activeIndex,
            'activeIcons.length > activeIndex');

  final double height;

  final double circleWidth;

  final Color color;

  final Color? circleColor;

  final List<Widget> activeIcons;

  final List<Widget> inactiveIcons;

  final EdgeInsets padding;

  final BorderRadius cornerRadius;

  final Color shadowColor;

  final Color? circleShadowColor;

  final double elevation;

  final Gradient? gradient;

  final Gradient? circleGradient;

  final int activeIndex;

  final Curve tabCurve;

  final Curve iconCurve;

  final int tabDurationMillSec;

  final int iconDurationMillSec;

  final void Function(int index)? onTap;

  final List<String> textActive;

  @override
  State<StatefulWidget> createState() => _CircleNavBarState();
}

class _CircleNavBarState extends State<CircleNavBar>
    with TickerProviderStateMixin {
  late AnimationController tabAc;

  late AnimationController activeIconAc;

  @override
  void initState() {
    super.initState();
    tabAc = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.tabDurationMillSec))
      ..addListener(() => setState(() {}))
      ..value = getPosition(widget.activeIndex);
    activeIconAc = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.iconDurationMillSec))
      ..addListener(() => setState(() {}))
      ..value = 1;
  }

  @override
  void didUpdateWidget(covariant CircleNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animation();
  }

  void _animation() {
    final nextPosition = getPosition(widget.activeIndex);
    tabAc
      ..stop()
      ..animateTo(nextPosition, curve: widget.tabCurve);
    activeIconAc
      ..reset()
      ..animateTo(1, curve: widget.iconCurve);
  }

  double getPosition(int i) {
    final itemCnt = widget.activeIcons.length;
    return i / itemCnt + (1 / itemCnt) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: widget.padding,
      width: double.infinity,
      height: widget.height,
      child: Column(
        children: [
          CustomPaint(
            painter: _CircleBottomPainter(
              iconWidth: widget.circleWidth,
              color: widget.color,
              circleColor: widget.circleColor ?? widget.color,
              xOffsetPercent: tabAc.value,
              boxRadius: widget.cornerRadius,
              shadowColor: widget.shadowColor,
              circleShadowColor: widget.circleShadowColor ?? widget.shadowColor,
              elevation: widget.elevation,
              gradient: widget.gradient,
              circleGradient: widget.circleGradient ?? widget.gradient,
            ),
            child: SizedBox(
              height: widget.height,
              width: double.infinity,
              child: Stack(
                children: [
                  Row(
                    children: widget.inactiveIcons.map((e) {
                      final currentIndex = widget.inactiveIcons.indexOf(e);
                      return Expanded(
                          child: GestureDetector(
                        onTap: () => widget.onTap?.call(currentIndex),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: widget.activeIndex == currentIndex ? null : e,
                        ),
                      ));
                    }).toList(),
                  ),
                  Positioned(
                      left: tabAc.value * deviceWidth -
                          widget.circleWidth / 2 -
                          tabAc.value *
                              (widget.padding.left + widget.padding.right),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: activeIconAc.value,
                            child: Container(
                              width: widget.circleWidth,
                              height: widget.circleWidth,
                              transform: Matrix4.translationValues(
                                  0,
                                  -(widget.circleWidth * 0.5) +
                                      _CircleBottomPainter.getMiniRadius(
                                          widget.circleWidth) -
                                      widget.circleWidth *
                                          0.5 *
                                          (1 - activeIconAc.value),
                                  0),
                              child: widget.activeIcons[widget.activeIndex],
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0,
                                -(widget.circleWidth * 0.4) +
                                    _CircleBottomPainter.getMiniRadius(
                                        widget.circleWidth) -
                                    widget.circleWidth *
                                        0.5 *
                                        (1 - activeIconAc.value),
                                0),
                            child: Text(
                              widget.textActive[widget.activeIndex],
                              style: appStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBottomPainter extends CustomPainter {
  _CircleBottomPainter({
    required this.iconWidth,
    required this.color,
    required this.circleColor,
    required this.xOffsetPercent,
    required this.boxRadius,
    required this.shadowColor,
    required this.circleShadowColor,
    required this.elevation,
    this.gradient,
    this.circleGradient,
  });

  final Color color;
  final Color circleColor;
  final double iconWidth;
  final double xOffsetPercent;
  final BorderRadius boxRadius;
  final Color shadowColor;
  final Color circleShadowColor;
  final double elevation;
  final Gradient? gradient;
  final Gradient? circleGradient;

  static double getR(double circleWidth) {
    return circleWidth / 2 * 1.2;
  }

  static double getMiniRadius(double circleWidth) {
    return getR(circleWidth) * 0.3;
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final paint = Paint();
    Paint? circlePaint;
    if (color != circleColor || circleGradient != null) {
      circlePaint = Paint()..color = circleColor;
    }

    final w = size.width;
    final h = size.height;
    final r = getR(iconWidth);
    final miniRadius = getMiniRadius(iconWidth);
    final x = xOffsetPercent * w;
    final firstX = x - r;
    final secondX = x + r;

    path
      ..moveTo(0, 0 + boxRadius.topLeft.y)
      ..quadraticBezierTo(0, 0, boxRadius.topLeft.x, 0)
      ..lineTo(firstX - miniRadius, 0)
      ..quadraticBezierTo(firstX, 0, firstX, miniRadius)
      ..arcToPoint(
        Offset(secondX, miniRadius),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..quadraticBezierTo(secondX, 0, secondX + miniRadius, 0)
      ..lineTo(w - boxRadius.topRight.x, 0)
      ..quadraticBezierTo(w, 0, w, boxRadius.topRight.y)
      ..lineTo(w, h - boxRadius.bottomRight.y)
      ..quadraticBezierTo(w, h, w - boxRadius.bottomRight.x, h)
      ..lineTo(boxRadius.bottomLeft.x, h)
      ..quadraticBezierTo(0, h, 0, h - boxRadius.bottomLeft.y)
      ..close();

    paint.color = color;

    if (gradient != null) {
      final shaderRect =
          Rect.fromCircle(center: Offset(w / 2, h / 2), radius: 180);
      paint.shader = gradient!.createShader(shaderRect);
    }

    if (circleGradient != null) {
      final shaderRect =
          Rect.fromCircle(center: Offset(x, miniRadius), radius: iconWidth / 2);
      circlePaint?.shader = circleGradient!.createShader(shaderRect);
    }

    canvas
      ..drawPath(
          path,
          Paint()
            ..color = shadowColor
            ..maskFilter = MaskFilter.blur(
                BlurStyle.normal, convertRadiusToSigma(elevation)))
      ..drawCircle(
          Offset(x, miniRadius),
          iconWidth / 2,
          Paint()
            ..color = circleShadowColor
            ..maskFilter = MaskFilter.blur(
                BlurStyle.normal, convertRadiusToSigma(elevation)))
      ..drawPath(path, paint)
      ..drawCircle(Offset(x, miniRadius), iconWidth / 2, circlePaint ?? paint);
  }

  @override
  bool shouldRepaint(_CircleBottomPainter oldDelegate) => oldDelegate != this;
}
