import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Rgb {
  final int red;
  final int green;
  final int blue;

  Rgb({this.red, this.green, this.blue});

  factory Rgb.fromJson(Map<String, dynamic> json) =>
    Rgb(red: json["red"], green: json["green"], blue: json["blue"]);

  Map<dynamic, dynamic> toJson() => {
      "red": red, "green":green, "blue": blue
  };
  
}

class Line {
  final String id;
  final String name;
  final String longName;
  final String description;
  final Rgb rgb; 


  Line({this.id, this.name, this.longName, this.description, this.rgb});

  factory Line.fromJson(Map<String, dynamic> json) =>
    Line(
     id: json["id"],
     name: json["name"],
     longName:json["longName"],
     description:json["description"],
     rgb: Rgb.fromJson(json["rgb"])   
    );

    Map<dynamic, dynamic> toJson() => {
      "id":id, "name":name, longName: "longName", description: "description"
    };
}

Future<List<Line>> fetchLine() async {
  final response = await http.get('https://transit-14c18.uc.r.appspot.com/api/lines');

  if (response.statusCode == 200) {
    var responseJson = jsonDecode(response.body);

    return (responseJson as List).map((p) => Line.fromJson(p)).toList(); 
  } else {
    throw Exception('Failed to load album');
  }
}