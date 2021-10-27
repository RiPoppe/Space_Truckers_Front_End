import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Models/planet.dart';
import 'package:space_truckers/Services/connection_service.dart';
import 'package:space_truckers/Services/planet_service.dart';

//TODO zorg ervoor dat er ook negatieve x coordinaten kunnen worden ingevuld
class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _formKey = GlobalKey<FormState>();
  bool addConnection = false;
  String name = "";
  int x = 0;
  int y = 0;
  String from = "";
  String to = "";
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add element",
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildElementSwitch(),
            addConnection ? _buildConnectionForm() : _buildPlanetForm(),
            const SizedBox(
              height: 20,
            ),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Column _buildPlanetForm() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
          child: Text("Planet name"),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Name",
            border: OutlineInputBorder(),
          ),
          validator: (val) => val!.isEmpty ? 'Enter a name' : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
        const SizedBox(
          child: Text("X coordinate"),
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "X coordinate",
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?\d+$'),
            )
          ],
          validator: (val) => val!.isEmpty ? "Enter a number" : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              x = int.tryParse(val)!;
            });
          },
        ),
        const SizedBox(
          child: Text("Y coordinate"),
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Y coordinate",
            border: OutlineInputBorder(),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (val) => val!.isEmpty ? "Enter a number" : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              y = int.tryParse(val)!;
            });
          },
        ),
      ],
    );
  }

  Column _buildConnectionForm() {
    return Column(
      children: [
        const SizedBox(
          child: Text("Connection From"),
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Planet Name",
            border: OutlineInputBorder(),
          ),
          validator: (val) =>
              val!.isEmpty ? 'Enter the name of a planet' : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              from = val;
            });
          },
        ),
        const SizedBox(
          child: Text("Connection To"),
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Planet Name",
            border: OutlineInputBorder(),
          ),
          validator: (val) =>
              val!.isEmpty ? 'Enter the name of a planet' : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              to = val;
            });
          },
        ),
        const SizedBox(
          child: Text("Connection Weight"),
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (val) =>
              val!.isEmpty ? "Enter a number greater than 0" : null,
          textAlign: TextAlign.center,
          onChanged: (val) {
            setState(() {
              weight = int.tryParse(val)!;
            });
          },
        ),
      ],
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
              if (!addConnection) {
                await PlanetService.addPlanet(
                    Planet(name: name, planetId: 0, x: x, y: y));
              } else {
                await ConnectionService.addConnection(from, to, weight, true);
              }
              GlobalFunctions.refreshUI();
              Navigator.pop(context, true);
            }
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Row _buildElementSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("    Planet"),
        Switch(
          value: addConnection,
          onChanged: (value) => setState(
            () {
              addConnection = value;
            },
          ),
        ),
        const Text("Connection"),
      ],
    );
  }
}
