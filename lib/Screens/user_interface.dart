import 'package:flutter/material.dart';
import 'package:space_truckers/Models/connection.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Services/connection_service.dart';
import 'package:space_truckers/Widgets/connection_button.dart';
//import 'package:flutter_html/flutter_html.dart';
import '../Widgets/curve_painter.dart';
import '../Models/planet.dart';
import '../Services/planet_service.dart';
import '../Widgets/planet_button.dart';

class UI extends StatefulWidget {
  const UI({
    Key? key,
  }) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  late Future<List<Planet>> planets;

  late Future<List<Connection>> connections;

  void fetchData() {
    planets = PlanetService.fetchPlanets();
    connections = ConnectionService.fetchConnections();
  }

  PlanetButton _buildPlanets(var item) {
    PlanetButton button = PlanetButton(
      item.name,
      item.x.toDouble(), //x coordinate planet button
      item.y.toDouble(), //y coordinate planet button
      item.planetId,
    );
    GlobalFunctions.planetButtons.add(button);
    return button;
  }

  ConnectionButton _buildConnections(Connection item) {
    ConnectionButton button = ConnectionButton(
        item.connectedWeight.toString(),
        (item.owner.x + item.connectedTo.x) /
            2.0, //x coordinate connection button
        (item.owner.y + item.connectedTo.y) /
            2.0, //y coordinate connection button
        item.connectionId);
    GlobalFunctions.connectionButtons.add(button);
    return button;
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return FutureBuilder<List<Connection>>(
      future: connections,
      builder: (contextConnection, snapshotConnection) {
        return FutureBuilder<List<Planet>>(
          future: planets,
          builder: (contextPlanet, snapshotPlanet) {
            if (snapshotPlanet.connectionState == ConnectionState.done &&
                snapshotConnection.connectionState == ConnectionState.done) {
              if (snapshotPlanet.hasData && snapshotConnection.hasData) {
                return CustomPaint(
                  painter:
                      CurvePainter(snapshotConnection.data!, contextConnection),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      for (var item in snapshotPlanet.data!)
                        _buildPlanets(item),
                      for (var item in snapshotConnection.data!)
                        _buildConnections(item),
                    ],
                  ),
                );
              } else if (snapshotPlanet.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
