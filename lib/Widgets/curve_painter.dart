import 'package:flutter/material.dart';
import '../Models/connection.dart';

class CurvePainter extends CustomPainter {
  List<Connection> connections = [];
  BuildContext? context;
  CurvePainter(this.connections, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 2;

    for (Connection connection in connections) {
      canvas.drawLine(
        Offset(
            MediaQuery.of(context!).size.width / 2 +
                connection.owner.x.toDouble() +
                30,
            connection.owner.y.toDouble() + 15),
        Offset(
            MediaQuery.of(context!).size.width / 2 +
                connection.connectedTo.x.toDouble() +
                30,
            connection.connectedTo.y.toDouble() + 15),
        paint,
      );
    }
  }

  void paintALine() {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
