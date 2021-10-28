// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Screens/user_interface.dart';

import 'Widgets/add_dialog.dart';
import 'Widgets/star_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //static String url = "https://spacetruckers2.azurewebsites.net";
  static String url = "https://localhost:44379";
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  UI ui = const UI();

  @override
  Widget build(BuildContext context) {
    GlobalFunctions.refreshUI = refresh;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: const Text(
            "Space Truckers",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          const LitStarfieldImpl(),
          ui,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDialog(context),
        tooltip: 'Add element',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void refresh() {
    setState(() {
      ui = UI();
    });
  }

  void _addDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddDialog(),
    );
    GlobalFunctions.planetButtons.clear();
    GlobalFunctions.updateFunctionsPlanets.clear();
    GlobalFunctions.connectionButtons.clear();
    GlobalFunctions.updateFunctionsConnections.clear();
    refresh();
  }
}
