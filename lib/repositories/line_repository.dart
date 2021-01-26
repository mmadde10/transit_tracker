import 'dart:async';
import 'package:meta/meta.dart';
import 'package:transit_tracker/models/line.dart';
import 'package:transit_tracker/repositories/line_api_client.dart';

class LineRepository {
  final LineApiClient lineApiClient;

  LineRepository({@required this.lineApiClient})
      : assert(lineApiClient != null);


  Future<List<Line>> getLines() async {
    return lineApiClient.fetchLines();
  }
}