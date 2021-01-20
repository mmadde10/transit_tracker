import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Stop {
  final int stopId;
  final String directionId;
  final String stopName;
  final String stationName;
  final String stationDescriptiveName;
  final bool ada;
  final bool red;
  final bool blue;
  final bool brown;
  final bool purple;
  final bool purpleExpress;
  final bool yellow;
  final bool pink;
  final bool orange;
  final String location;

  Stop({this.stopId, this.directionId, this.stopName, this.stationName, this.stationDescriptiveName, this.ada, this.red, this.blue, this.brown, this.purple, this.purpleExpress, this.yellow, this.pink, this.orange, this.location});

  factory Stop.fromJson(Map<String, dynamic> json) => 
    Stop(
      stopId: json["stopID"],
      directionId: json["directionID"],
      stopName: json["stopName"],
      stationName: json["stationName"],
      stationDescriptiveName: json["stationDescriptiveName"],
      ada: json["ADA"],
      red: json["RED"],
      blue: json["BLUE"],
      brown: json["BRN"],
      purple: json["P"],
      purpleExpress: json["Pexp"],
      yellow: json["Y"],
      pink: json["Pnk"],
      orange: json["O"],
      location:json["Location"]
    );

    Map<dynamic, dynamic> toJson() =>{
      "stopId":stopId, 
      "directionId": directionId, 
      "stopName": stopName,
      "stationDescriptiveName": stationDescriptiveName,
      "ada": ada,
      "red": red,
      "blue": blue,
      "brown": brown,
      "purple": purple,
      "purpleExpress": purpleExpress,
      "yellow": yellow,
      "pink": pink,
      "orange": orange,
      "location": location
    };
}

Future<List<Stop>> fetchStops(String lineId) async {
    final response = await http.get('https://transit-14c18.uc.r.appspot.com/api/stops?line=$lineId');
    
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
       return (responseJson as List).map((p) => Stop.fromJson(p)).toList(); 
    }
    else {
    throw Exception('Failed to load album');
  }
}