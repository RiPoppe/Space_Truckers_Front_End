import 'package:space_truckers/Models/planet.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanetService {
  static Future<Planet> fetchPlanet(String url, int id) async {
    Uri uri = Uri.parse(url + '/Planet/' + id.toString());
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

  static Future<List<Planet>> fetchPlanets(String url) async {
    final response = await http.get(Uri.parse(url + '/Planet'));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (responseJson as List).map((p) => Planet.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Planet');
    }
  }

  static Future<String> addPlanet(String url, Planet planet) async {
    url = url + "/Planet/";
    var body = (planet);
    var header = {"content-type": "application/json"};
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: json.encode(planet),
    );

    return "yes";
  }
}
