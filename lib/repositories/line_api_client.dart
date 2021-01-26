import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:transit_tracker/models/line.dart';

/*
class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);
}
*/

class LineApiClient {
  static const baseUrl = 'https://transit-14c18.uc.r.appspot.com';
  final http.Client httpClient;

  LineApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Line>> fetchLines() async {
    final lineUrl = '$baseUrl/api/lines';
    final lineResponse = await this.httpClient.get(lineUrl);

    if (lineResponse.statusCode != 200) {
      throw Exception('error getting lines');
    }
    var responseJson = jsonDecode(lineResponse.body);
    return (responseJson as List).map((p) => Line.fromJson(p)).toList(); 
  }

}