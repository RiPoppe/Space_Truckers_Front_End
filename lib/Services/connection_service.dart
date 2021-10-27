import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_truckers/Models/connection.dart';

import '../main.dart';

class ConnectionService {
  static Future<List<Connection>> fetchConnections() async {
    final response = await http.get(Uri.parse(MyApp.url + '/Connection'));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (responseJson as List).map((p) => Connection.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Connections');
    }
  }

  static Future addConnection(
      String from, String to, int weight, bool both) async {
    String url = MyApp.url +
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

    var header = {"content-type": "application/json"};
    await http.post(
      Uri.parse(url),
      headers: header,
    );
  }

  static Future deleteConnection(int connectionId) async {
    String url = MyApp.url + "/Connection/" + connectionId.toString();

    await http.delete(
      Uri.parse(url),
    );
    print("deleted");
  }
}
