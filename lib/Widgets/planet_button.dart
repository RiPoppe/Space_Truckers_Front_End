import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_truckers/Models/dijkstra.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Services/planet_service.dart';

class PlanetButton extends StatefulWidget {
  final String name;
  final double x;
  final double y;
  final int planetId;
  const PlanetButton(this.name, this.x, this.y, this.planetId, {Key? key})
      : super(key: key);

  @override
  State<PlanetButton> createState() => _PlanetButtonState();
}

class _PlanetButtonState extends State<PlanetButton> {
  double borderWidth = 0;
  Color borderColor = Colors.white;

  void onPressed() async {
    try {
      setState(() {
        if (Dijkstra.planetPressed(widget.name)!) {
          borderWidth = 5;
        } else {
          borderWidth = 0;
        }
      });
      if (Dijkstra.planetsPressed.length == 2 &&
          !(GlobalFunctions.planetButtons
                  .indexWhere((element) => element.name == widget.name) ==
              -1)) {
        GlobalFunctions.result = await Dijkstra.determineShortestPath();
        print("The shortest path = " + GlobalFunctions.result.toString());
        GlobalFunctions.callFunctions(true);
      } else {
        GlobalFunctions.callFunctions(false);
      }
    } catch (e) {
      //Do nothing since the expection is thrown when nothing should be done
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

  void deleteConnections() async {
    await PlanetService.deletePlanet(widget.planetId);

    GlobalFunctions.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    GlobalFunctions.updateFunction(widget.name, onRoute);
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
            onLongPress: deleteConnections,
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
