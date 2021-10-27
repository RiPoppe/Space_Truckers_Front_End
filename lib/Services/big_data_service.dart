/* //https://sterdbapi.azurewebsites.net/c-sharp/1
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_truckers/Models/big_data.dart';

class BigDataService {
  static Future<List<Data>> fetchData(int id) async {
    Uri uri = Uri.parse(
        "https://sterdbapi.azurewebsites.net/c-sharp/" + id.toString());
    final response = await http.get(uri);
    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return (responseJson as List).map((p) => Connection.fromJson(p)).toList();

      var result =
          (responseJson as List).map((data) => Data.fromJson(data)).toList();
      print(result);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
 */