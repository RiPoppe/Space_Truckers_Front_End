import 'package:flutter/material.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Models/planet.dart';
import 'package:space_truckers/Services/planet_service.dart';

class UpdateDialog extends StatefulWidget {
  final String name;
  final int planetId;
  final int x;
  final int y;

  const UpdateDialog(this.name, this.planetId, this.x, this.y, {Key? key})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  int x = 0;
  int y = 0;
  final _formKey = GlobalKey<FormState>();

  bool isValidInput(String string) {
    // Null or empty string is not a number
    if (string.isEmpty) {
      return false;
    }

    // Try to parse input string to number.
    // Both integer and double work.
    // Use int.tryParse if you want to check integer only.
    // Use double.tryParse if you want to check double only.
    final number = int.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Update Planet",
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
              child: Text("X coordinate"),
            ),
            TextFormField(
              initialValue: widget.x.toString(),
              //TextInputType.numberWithOptions(signed: true, decimal: false),
              decoration: const InputDecoration(
                hintText: "number",
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              validator: (val) => !isValidInput(val!) ? "Enter a number" : null,
              onChanged: (val) {
                setState(() {
                  x = int.tryParse(val)!;
                });
              },
            ),
            const SizedBox(
              height: 20,
              child: Text("Y coordinate"),
            ),
            TextFormField(
              initialValue: widget.y.toString(),
              decoration: const InputDecoration(
                hintText: "number",
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              validator: (val) =>
                  val!.isEmpty ? "Enter a number greater than 0" : null,
              onChanged: (val) {
                setState(() {
                  y = int.tryParse(val)!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Row _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Icon(Icons.undo),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              PlanetService.updatePlanet(
                Planet(
                    name: widget.name, planetId: widget.planetId, x: x, y: y),
                widget.planetId,
              );
              GlobalFunctions.refreshUI();
              Navigator.pop(context, true);
            }
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
