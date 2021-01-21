import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Arrival {
  final String arrivalTime;
  final String destinationName;
  final String destinationSt;
  final String runNumber;
  final String stationName;
  final String stationDeparture;
  final String predictedTime;

  Arrival({this.arrivalTime, this.destinationName, this.destinationSt, this.runNumber, this.stationName, this.stationDeparture, this.predictedTime});


  factory Arrival.fromJson(Map<String, dynamic> json) =>
    Arrival(
      arrivalTime:json["arrt"],
      destinationName: json["destNm"],
      destinationSt: json["destSt"],
      runNumber: json["rn"],
      stationName: json["staNm"],
      stationDeparture: json["stpDe"],
      predictedTime: json["prdt"],
    );

  Map<dynamic, dynamic> toJson() => {
    "arrt": arrivalTime, "destNm": destinationName, "destSt": destinationSt, "rn": runNumber, "staNm": stationName, "stpDe": stationDeparture, "prdt": predictedTime
  };
}

Future<List<Arrival>> fetchArrivals(int stopId) async {
  final response = await http.get("https://transit-14c18.uc.r.appspot.com/api/arrivals/$stopId");
  
  if (response.statusCode == 200) {
    var responseJson = jsonDecode(response.body);

    return (responseJson['Ctatt']["ETA"] as List).map((p) => Arrival.fromJson(p)).toList(); 
  } else {
    throw Exception('Failed to get lines');
  }
}