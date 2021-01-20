import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transit_tracker/models/stop.dart';


class StopList extends StatefulWidget {
  StopList({Key key, this.lineCode, this.lineName}) : super(key: key);
  final String lineCode;
  final String lineName;

  @override
  _StopListState createState() => _StopListState(lineCode, lineName);
}

class _StopListState extends State<StopList>{
  Future<List<Stop>> futureStop;
  final String lineCode;
  final String lineName;

  _StopListState(this.lineCode, this.lineName);

  @override
  void initState() {
    super.initState();
    futureStop = fetchStops('BRN');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(lineName),
      ),
    body: Center(
       child: FutureBuilder<List<Stop>>(
         future: futureStop,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                      return Text(snapshot.data[index].stationName);
                    }
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text(" herre \n${snapshot.error}");
                   }
              return CircularProgressIndicator();
              },
       )
    )
    );
  }           
}