/* import 'package:flutter/material.dart';

class Data {
  final double distance;
/*   final int connectionId;
  final int connectedWeight;
  final Planet connectedTo;
  final Planet owner; */
  Data({
    required this.distance,
/*     required this.connectedWeight,
    required this.owner,
    required this.connectedTo,
    required this.connectionId, */
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      distance: json['distance'],
      /*      connectedWeight: json['connectedWeight'],
      owner: Planet.fromJson(json['owner']),
      connectedTo: Planet.fromJson(json['connectedTo']),
      connectionId: json['connectionId'], */
    );
  }
}
 */