import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget {
  final String weight;
  final double x;
  final double y;

  const ConnectionButton(this.weight, this.x, this.y, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const CircleBorder(side: BorderSide.none),
        ),
        onPressed: () => null,
        child: Text(
          weight.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      left: MediaQuery.of(context).size.width / 2 + (x),
      top: y,
    );
  }
}
