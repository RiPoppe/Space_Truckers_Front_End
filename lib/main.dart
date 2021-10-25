import 'package:flutter/material.dart';
import 'package:space_truckers/Screens/user_interface.dart';

import 'Widgets/add_dialog.dart';
import 'Widgets/star_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
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
  UI ui = UI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // ignore: prefer_const_constructors
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

  void _addDialog(BuildContext context) async {
    final add = await showDialog(
      context: context,
      builder: (context) => const AddDialog(),
    );

    if (add != null) {
      setState(() {
        ui = UI();
      });
    }
  }
}
