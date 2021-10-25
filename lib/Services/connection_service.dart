import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_truckers/Models/connection.dart';

class ConnectionService {
  static Future<List<Connection>> fetchConnections(String url) async {
    final response = await http.get(Uri.parse(url + '/Connection'));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (responseJson as List).map((p) => Connection.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<String> addConnection(
      String url, String from, String to, int weight, bool both) async {
    url = url +
        "/Connection?planetA=" +
        from +
        "&planetB=" +
        to +
        "&weightAtoB=" +
        weight.toString() +
        "&weightBtoA=" +
        weight.toString() +
        "&both=" +
        true.toString();
    //https: //localhost:44379/Connection?planetA=A&planetB=C&weightAtoB=4&weightBtoA=33&both=true
    //var body = (connection);
    var header = {"content-type": "application/json"};
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      //body: json.encode(connection),
    );

    return "yes";
  }
}
