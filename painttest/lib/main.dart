import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xfffbfaff),
        child: CustomPaint(
          painter: BackgroundPaint(),
        ),
      ),
    );
  }
}

class CellInfo {
  final int index;
  final int type;
  final Color color;

  CellInfo(this.index, this.type, this.color );
}


class BackgroundPaint extends CustomPainter {
  @override
  var list = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
              'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
              'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
              'Y', 'Z', '1', '2', '3', '4', '5', '6'];

  final _cellInfo = List.generate(32, (i) => CellInfo(i, i, Color.fromARGB(255, 50, 39, 19)));

  void paint(Canvas canvas, Size size) {
    var paint1 = Paint();

    paint1.color = Color.fromARGB(255, 250, 39, 19);


//    final agag = _cellInfo[0];
//    print('type = $agag.index');


    int? x;
    int? y;

    for (int j = 0; j < 4; j++) {
      for (int i = 0; i < 8; i++) {
        x = i * 30 + 20;
        y = j * 30 + 50;

//        _cellInfo[0].index = j + i;
//        cellinfo[j * 8 + i].type = j * 8 + i;
//        cellinfo[j + i].color = Color.fromARGB(255, Random().nextInt(55), Random().nextInt(55), Random().nextInt(55));




        ///   사각형 박스 size(20, 20)그림
        canvas.drawRect(
            Offset(x.toDouble(), y.toDouble()) & const Size(20, 20), paint1);
        
        ///   사각형 박스위에 써지는 A~Z, 1~6숫자
        _drawText(canvas,
            x,
            y,
            list[j * 8 + i],
            TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black));

      }
    }
  }

  void _drawText(Canvas canvas, centerX, centerY, text, style) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center

      ..layout();

    final xCenter = (centerX + 10 - textPainter.width / 2);
    final yCenter = (centerY + 10 - textPainter.height / 2);
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegte) => false;
}

