import 'package:space_truckers/Models/planet.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';

class PlanetService {
  static Future<Planet> fetchPlanet(int id) async {
    Uri uri = Uri.parse(MyApp.url + '/Planet/' + id.toString());
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Planet.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Planet');
    }
  }

  static Future<List<Planet>> fetchPlanets() async {
    final response = await http.get(Uri.parse(MyApp.url + '/Planet'));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (responseJson as List).map((p) => Planet.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Planets');
    }
  }

  static Future addPlanet(Planet planet) async {
    String url = MyApp.url + "/Planet/";
    var header = {"content-type": "application/json"};
    await http.post(
      Uri.parse(url),
      headers: header,
      body: json.encode(planet),
    );
  }

  static Future updatePlanet(Planet planet, int id) async {
    String url = MyApp.url + "/Planet/" + id.toString();
    var header = {"content-type": "application/json"};
    await http.put(
      Uri.parse(url),
      headers: header,
      body: json.encode(planet),
    );
  }

  static Future deletePlanet(int connectionId) async {
    String url = MyApp.url + "/Planet/" + connectionId.toString();

    await http.delete(
      Uri.parse(url),
    );
  }
}
