import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transit_tracker/components/arrival_grid.dart';
import 'package:transit_tracker/models/stop.dart';


class StopList extends StatefulWidget {
  StopList({Key key, this.lineCode, this.lineName, this.lineColor}) : super(key: key);
  final String lineCode;
  final String lineName;
  final Color lineColor;

  @override
  _StopListState createState() => _StopListState(lineCode, lineName, lineColor);
}

class _StopListState extends State<StopList>{
  Future<List<Stop>> futureStop;
  final String lineCode;
  final String lineName;
  final Color lineColor;

  _StopListState(this.lineCode, this.lineName, this.lineColor);

  @override
  void initState() {
    super.initState();
    futureStop = fetchStops(lineCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lineColor,
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
                     return StopListItem(
                              snapshot.data[index].stationName,
                              snapshot.data[index].stationDescriptiveName,
                              snapshot.data[index].stopId,
                              snapshot.data[index].ada,
                              snapshot.data[index].stopName,
                              lineColor
                            );
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

class StopListItem extends StatelessWidget{
  final String stationName;
  final String stationDescriptiveName;
  final int stopId;
  final bool ada;
  final String stopName;
  final Color lineColor;

  const StopListItem(this.stationName, this.stationDescriptiveName, this.stopId,this.ada, this.stopName, this.lineColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
              leading: Icon(Icons.train),
              title: new Text(stopName),
              trailing: ada ? Icon(Icons.accessible) : null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArrivalGrid(stationName: stationName, stopId: stopId, lineColor: lineColor)));
              }
            )
      );
  }
}