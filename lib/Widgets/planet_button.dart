import 'dart:math';

import 'package:flutter/material.dart';

class PlanetButton extends StatefulWidget {
  final String name;
  final double x;
  final double y;

  PlanetButton(this.name, this.x, this.y, {Key? key}) : super(key: key);

  @override
  State<PlanetButton> createState() => _PlanetButtonState();
}

class _PlanetButtonState extends State<PlanetButton> {
  bool isPressed = false;

  double borderWidth = 0;

  void onPressed() {
    isPressed = !isPressed;
    print("pressed");
    setState(() {
      if (isPressed) {
        borderWidth = 5;
      } else {
        borderWidth = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Tooltip(
        message: "Name: " + widget.name,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: borderWidth,
                color: Colors.white,
              )),
          alignment: Alignment.center,
//          margin: EdgeInsets.all(5),
          // color: Colors.white,
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

/* import 'dart:math';

import 'package:flutter/material.dart';

class PlanetButton extends StatelessWidget {
  final String name;
  final double x;
  final double y;

  const PlanetButton(this.name, this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Tooltip(
        message: "Name: " + name,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              shape: const CircleBorder(side: BorderSide.none),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
          onPressed: () => null,
          child: Text(
            name.toUpperCase(),
          ),
        ),
        /* child: RaisedButton(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          textColor: Colors.white,
          shape: const CircleBorder(side: BorderSide.none),
          child: Text(
            name.toUpperCase(),
            style: const TextStyle(fontSize: 20),
          ),
          onPressed: () => null,
        ), */
      ),
      left: MediaQuery.of(context).size.width / 2 + (x),
      top: y,
    );
  }
}
 */