import 'package:flutter/material.dart';
import 'package:space_truckers/Models/connection.dart';
import 'package:space_truckers/Models/global_functions.dart';
import 'package:space_truckers/Services/connection_service.dart';

class ConnectionButton extends StatefulWidget {
  final String weight;
  final double x;
  final double y;
  final int connectionId;
  const ConnectionButton(this.weight, this.x, this.y, this.connectionId,
      {Key? key})
      : super(key: key);

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  Color connectionColor = Colors.white;

  void onRoute(bool showRoute) {
    setState(() {
      if (!showRoute) {
        connectionColor = Colors.white;
      } else {
        connectionColor = Colors.yellow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: connectionColor,
          shape: const CircleBorder(side: BorderSide.none),
        ),
        onPressed: () => {},
        onLongPress: () {
          deleteConnections();
        },
        child: Text(
          widget.weight.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      left: MediaQuery.of(context).size.width / 2 + (widget.x),
      top: widget.y,
    );
  }

  void deleteConnections() async {
    List<Connection> connections = await ConnectionService.fetchConnections();
    String from = "";
    String to = "";
    for (var connection in connections) {
      if (connection.connectionId == widget.connectionId) {
        from = connection.owner.name;
        to = connection.connectedTo.name;
      }
    }

    for (var con in connections) {
      if (con.connectedTo.name == from && con.owner.name == to) {
        await ConnectionService.deleteConnection(con.connectionId);
      } else if (con.connectedTo.name == to && con.owner.name == from) {
        await ConnectionService.deleteConnection(con.connectionId);
      }
    }

    GlobalFunctions.refreshUI();
  }
}
