import 'package:space_truckers/Models/planet.dart';

class Connection {
  final int connectedWeight;
  final Planet connectedTo;
  final Planet owner;
  Connection({
    required this.connectedWeight,
    required this.owner,
    required this.connectedTo,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      connectedWeight: json['connectedWeight'],
      owner: Planet.fromJson(json['owner']),
      connectedTo: Planet.fromJson(json['connectedTo']),
    );
  }
}
