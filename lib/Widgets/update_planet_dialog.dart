import 'package:flutter/material.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Models/planet.dart';
import 'package:space_truckers/Services/planet_service.dart';

class UpdatePlanetDialog extends StatefulWidget {
  final String name;
  final int planetId;
  final int x;
  final int y;

  const UpdatePlanetDialog(this.name, this.planetId, this.x, this.y, {Key? key})
      : super(key: key);

  @override
  _UpdatePlanetDialogState createState() => _UpdatePlanetDialogState();
}

class _UpdatePlanetDialogState extends State<UpdatePlanetDialog> {
  int? x = 0;
  int? y = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    x = widget.x;
    y = widget.y;
  }

  String? isInvalidInput(String string, bool isX) {
    int? number = int.tryParse(string);
    if (number == null) {
      return "Enter a number";
    }

    int minx = -MediaQuery.of(context).size.width ~/ 2;
    int maxx = MediaQuery.of(context).size.width ~/ 2;
    int maxy = (MediaQuery.of(context).size.height).toInt();

    if (!isX && (number < 0 || number > maxy)) {
      return "Enter a number between 0 and $maxy";
    } else if (isX && (number < minx || number > maxx)) {
      return "Enter a number between $minx & $maxx";
    }

    return null;
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
              initialValue: x.toString(),
              //TextInputType.numberWithOptions(signed: true, decimal: false),
              decoration: const InputDecoration(
                hintText: "number",
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              validator: (val) => isInvalidInput(val!, true),
              onChanged: (val) {
                setState(() {
                  try {
                    x = int.tryParse(val)!;
                  } catch (e) {
                    x = null;
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
              child: Text("Y coordinate"),
            ),
            TextFormField(
              initialValue: y.toString(),
              decoration: const InputDecoration(
                hintText: "number",
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              validator: (val) => isInvalidInput(val!, false),
              onChanged: (val) {
                setState(() {
                  try {
                    y = int.tryParse(val)!;
                  } catch (e) {
                    y = null;
                  }
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
                    name: widget.name, planetId: widget.planetId, x: x!, y: y!),
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
