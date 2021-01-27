import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:transit_tracker/models/line.dart';


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
    final responseJson = jsonDecode(lineResponse.body);
    return (responseJson as List).map((p) => Line.fromJson(p)).toList(); 
  }

}