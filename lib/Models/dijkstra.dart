import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class Dijkstra {
  Dijkstra();
  static List<String> planetsPressed = <String>[];
  static String? from;
  static String? to;

  static bool? planetPressed(String planet) {
    if (planetsPressed.contains(planet)) {
      planetsPressed.remove(planet);
      return false;
    } else if (planetsPressed.length < 2) {
      planetsPressed.add(planet);
      return true;
    }
  }

  static Future<List<String>> determineShortestPath() async {
    Uri uri = Uri.parse(MyApp.url +
        "/GetPath?from=" +
        planetsPressed[0] +
        "&to=" +
        planetsPressed[1]);
    final response = await http.get(uri);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (responseJson as List).map((e) => e.toString()).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to determine the shortest path');
    }
  }
}
