import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/DashBoardTablePainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int splitCount = 6;
  int speed = 6 * 2 + 1;
  Size dashBoardSize;
  bool isStart = false;
  var width;
  @override
  void initState() {
    super.initState();
    dashBoardSize = new Size(281, 281);
    if (!isStart) {
      isStart = true;
      for (int i = 1; i <= 1000; i++) {
        Future.delayed(new Duration(milliseconds: i * 1000), () {
          setState(() {
            speed = Random().nextInt(splitCount * 2 + 1);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: CustomPaint(
                painter: DashBoardTablePainter(dashBoardSize,
                    needMoveCenter: false,
                    splitCount: splitCount,
                    speed: speed,
                    scale: 10,
                    length: 40,
                    speedUnitFontSize: 20,
                    speedFontSize: 48,
                    stateTextFontSize: 18,
                    bottomValueFontSize: 20,
                    bottomUnitFontSize: 12,
                    circleRadius: 80,
                    circleColor: Colors.white,
                    calcScale: 1 / (splitCount * 2 + 1),
                    stateTextColor: Color(0xff006AC7),
                    noSpeedColor: Color(0xffD8D8D8),
                    speedColor: Color(0xff006AC7),
                    shadowColor1: Color(0xfff9f9f9),
                    shadowColor2: Color(0xfff6f6f6)))),
      ),
    );
  }
}
