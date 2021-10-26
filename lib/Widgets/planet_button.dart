import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_truckers/Models/dijkstra.dart';
import 'package:space_truckers/Models/show_result.dart';
import 'package:space_truckers/main.dart';

class PlanetButton extends StatefulWidget {
  final String name;
  final double x;
  final double y;
  const PlanetButton(this.name, this.x, this.y, {Key? key}) : super(key: key);

  @override
  State<PlanetButton> createState() => _PlanetButtonState();
}

class _PlanetButtonState extends State<PlanetButton> {
  double borderWidth = 0;
  Color borderColor = Colors.white;
  void onPressed() async {
    setState(() {
      if (Dijkstra.planetPressed(widget.name)!) {
        borderWidth = 5;
      } else {
        borderWidth = 0;
      }
    });
    if (Dijkstra.planetsPressed.length == 2 &&
        !(ShowResult.pbuttons
                .indexWhere((element) => element.name == widget.name) ==
            -1)) {
      ShowResult.result = await Dijkstra.determineShortestPath();
      print(ShowResult.result);
      ShowResult.callFunctions(true);
    } else {
      ShowResult.callFunctions(false);
    }
  }

  void onRoute(bool showRoute) {
    setState(() {
      if (!showRoute) {
        borderColor = Colors.white;
        borderWidth = 0;
      } else {
        borderColor = Colors.yellow;
        borderWidth = 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ShowResult.updateFunctions.add(onRoute);
    print("F " + ShowResult.updateFunctions.length.toString());
    return Positioned(
      child: Tooltip(
        message: "Name: " + widget.name,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: borderWidth,
                color: borderColor,
              )),
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                shape: const CircleBorder(side: BorderSide.none),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            onPressed: onPressed,
            child: Text(
              widget.name.toUpperCase(),
            ),
          ),
        ),
      ),
      left: MediaQuery.of(context).size.width / 2 + (widget.x) - borderWidth,
      top: widget.y - borderWidth,
    );
  }
}
