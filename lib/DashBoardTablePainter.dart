import 'dart:ui';
import 'package:flutter/material.dart';

///**
///* 刘亚林 2019/8/15
///*/
class DashBoardTablePainter extends CustomPainter {
  double tableSpace;
  final Size oursize;
  int speed;

  final double wholeCirclesRadian = 6.283185307179586;
  int tableCount = 21;
  int splitCount = 16;
  double scale = 12.0;
  double length = 40.0;
  double circleRadius = 85;
  Color shadowColor1;
  Color shadowColor2;
  Color noSpeedColor;
  Color speedColor;
  Color circleColor;
  Color stateTextColor;
  Color speedTextColor;
  Color speedUnitColor;
  String unit;
  int startValue;
  int maxValue;
  double calcScale;
  int keepDecimalCount;
  String stateText;
  double speedFontSize;
  double stateTextFontSize;
  double speedUnitFontSize;
  double bottomValueFontSize;
  double bottomUnitFontSize;
  bool needMoveCenter;

  DashBoardTablePainter(this.oursize,
      {this.needMoveCenter = true,
      this.speed = 0,
      this.splitCount = 12,
      this.scale = 12,
      this.length = 40,
      this.circleRadius = 85,
      this.stateText = "正常",
      this.startValue = 0,
      this.maxValue = 1,
      this.calcScale = 0.04,
      this.keepDecimalCount = 1,
      this.unit = "KM/H",
      this.speedFontSize = 48,
      this.speedUnitFontSize = 20,
      this.stateTextFontSize = 18,
      this.bottomValueFontSize = 20,
      this.bottomUnitFontSize = 12,
      this.stateTextColor = Colors.blue,
      this.speedTextColor = Colors.black,
      this.speedUnitColor = Colors.black,
      this.shadowColor1 = Colors.blueGrey,
      this.shadowColor2 = Colors.white12,
      this.speedColor = Colors.blue,
      this.noSpeedColor = Colors.black,
      this.circleColor = Colors.white}) {
    tableCount = (splitCount * 2 / 0.75).floor();
    tableSpace = wholeCirclesRadian / tableCount;
  }

  //_splitCount请最好是双数

  int getMax() {
    return tableCount + 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(oursize.toString());
    drawWheelChairTable(canvas, oursize);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawWheelChairTable(Canvas canvas, Size size) {
    double cx = size.width / 2;
    double cy = size.height / 2;
    if (needMoveCenter) canvas.translate(cx, cy);
    canvas.rotate((splitCount + 1) * tableSpace);
    canvas.save();
    canvas.restore();
    int xxx = 0;
    for (int i = splitCount * 2; i >= 0; i--) {
      xxx++;
      canvas.rotate(-tableSpace);
      drawRRLine(canvas, getDrawPaintBySpeed(i), cy);
    }
    print("xxx:" +
        xxx.toString() +
        ";splitCount + 1:" +
        (splitCount + 1).toString());
    drawCircle(canvas);
    drawSpeedText(canvas);
  }

  void drawRRLine(Canvas canvas, Paint paintMain, double halfHeight) {
    double circular = scale / 2;
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(0.0, -halfHeight, scale, length),
            topLeft: Radius.circular(circular),
            topRight: Radius.circular(circular),
            bottomRight: Radius.circular(circular),
            bottomLeft: Radius.circular(circular)),
        paintMain);
  }

  void drawCircle(Canvas canvas) {
    canvas.save();
    canvas.drawCircle(
        Offset(0, 0), circleRadius + 6, getDrawPaintByCircleShadow(1));
    canvas.drawCircle(
        Offset(0, 0), circleRadius + 3, getDrawPaintByCircleShadow(2));
    canvas.drawCircle(Offset(0, 0), circleRadius, getDrawPaintByCircle());
    canvas.restore();
  }

  void drawSpeedText(Canvas canvas) {
    canvas.save();
    canvas.rotate(-tableSpace * (splitCount * 1.5 + (splitCount / 6).floor()));
    TextPainter textPainter = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: startValue.toString(),
            style:
                TextStyle(color: Colors.black, fontSize: bottomValueFontSize)));
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2 - circleRadius + length,
            oursize.height / 2 - 2 * textPainter.height - 5));
    TextPainter textPainter2 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: unit,
            style:
                TextStyle(color: Colors.black, fontSize: bottomUnitFontSize)));
    textPainter2.layout();
    textPainter2.paint(
        canvas,
        Offset(-textPainter2.width / 2 - circleRadius + length,
            oursize.height / 2 - 2 * textPainter2.height));

    TextPainter textPainter3 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: maxValue.toString(),
            style:
                TextStyle(color: Colors.black, fontSize: bottomValueFontSize)));
    textPainter3.layout();
    textPainter3.paint(
        canvas,
        Offset(circleRadius - textPainter3.width / 2 - length,
            oursize.height / 2 - 2 * textPainter3.height - 5));
    TextPainter textPainter4 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: unit,
            style: TextStyle(
                color: speedTextColor, fontSize: bottomUnitFontSize)));
    textPainter4.layout();
    textPainter4.paint(
        canvas,
        Offset(circleRadius - textPainter4.width / 2 - length,
            oursize.height / 2 - 2 * textPainter4.height));

    TextPainter textPainter5 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: stateText,
            style:
                TextStyle(color: stateTextColor, fontSize: stateTextFontSize)));
    textPainter5.layout();
    textPainter5.paint(
        canvas, Offset(-textPainter5.width / 2, -speedFontSize - 2));

    TextPainter textPainter6 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: (speed * calcScale).toStringAsFixed(keepDecimalCount),
            style: TextStyle(color: speedTextColor, fontSize: speedFontSize)));
    textPainter6.layout();
    textPainter6.paint(
        canvas, Offset(-textPainter6.width / 2, -textPainter6.height / 2));

    TextPainter textPainter7 = new TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: unit,
            style:
                TextStyle(color: speedUnitColor, fontSize: speedUnitFontSize)));
    textPainter7.layout();
    textPainter7.paint(
        canvas,
        Offset(-textPainter7.width / 2,
            speedFontSize / 2 + textPainter7.height / 2));
    canvas.restore();
  }

  void drawBottomSpeed() {}

  Paint getDrawPaintBySpeed(int i) {
    Paint paint = new Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.fill;
    if (speed <= i) {
      paint.color = noSpeedColor;
    } else {
      paint.color = speedColor;
    }
    return paint;
  }

  Paint getDrawPaintByCircle() {
    Paint paint = new Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.fill;
    paint.color = circleColor;
    return paint;
  }

  Paint getDrawPaintByCircleShadow(int i) {
    Paint paint = new Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.fill;
    if (i == 1) {
      paint.color = shadowColor1;
    } else {
      paint.color = shadowColor2;
    }
    return paint;
  }
}
