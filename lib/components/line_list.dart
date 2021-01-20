import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transit_tracker/components/stops_list.dart';
import 'package:transit_tracker/models/line.dart';

class LineList extends StatefulWidget {
  LineList({Key key}) : super(key: key);

  @override
  _LineListState createState() => _LineListState();
}

class _LineListState extends State<LineList>{
  Future<List<Line>> futureLine;

  @override
  void initState() {
    super.initState();
    futureLine = fetchLine();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
       child: FutureBuilder<List<Line>>(
         future: futureLine,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CustomListItem(
                      snapshot.data[index].name, 
                      snapshot.data[index].description, 
                      snapshot.data[index].rgb.red, 
                      snapshot.data[index].rgb.green, 
                      snapshot.data[index].rgb.blue,
                      snapshot.data[index].longName,);
                    }
                );
              } else if (snapshot.hasError) {
                return Text(" herre \n${snapshot.error}");
              }
              return CircularProgressIndicator();
          },
      )
    );
  }
}


class CustomListItem extends StatelessWidget {

  final String name;
  final String longName;
  final String description;
  final int red;
  final int green;
  final int blue;


  const CustomListItem(this.name,this.description, this.red, this.green, this.blue, this.longName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
         leading: Icon(Icons.train, color: Color.fromRGBO(red, green, blue, 1.0), size: 32.0),
         title: new Text(longName),
         subtitle: new Text(description),
         onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StopList(lineName: name, lineCode: 'brn',))
            );
         },
      )
    );
  }
}