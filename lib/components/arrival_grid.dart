import 'package:flutter/material.dart';
import 'package:transit_tracker/models/arrival.dart';

import 'arrival_card.dart';


class ArrivalGrid extends StatefulWidget{
    const ArrivalGrid({Key key, this.stationName, this.stopId, this.lineColor}) : super(key: key);
    final String stationName;
    final int stopId;
    final Color lineColor;

    @override
    _ArrivalGridState createState() => _ArrivalGridState(stationName,stopId,lineColor);
}

class _ArrivalGridState extends State<ArrivalGrid>{
    Future<List<Arrival>> futureArrival;
  final String stationName;
  final int stopId;
  final Color lineColor;

  _ArrivalGridState(this.stationName, this.stopId, this.lineColor);
  

  @override
  void initState(){
    super.initState();
    futureArrival = fetchArrivals(stopId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: lineColor,
        title: Text(stationName),
      ),
       body:Center(
       child: FutureBuilder<List<Arrival>>(
         future: futureArrival,
         builder: (context, snapshot){
           if(snapshot.hasData){
             return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 3.0, mainAxisSpacing: 3.0),
              itemBuilder: (context, index){
               return ArrivalCard(
                  snapshot.data[index].arrivalTime,
                  snapshot.data[index].destinationName,
                  snapshot.data[index].predictedTime,
                  snapshot.data[index].stationDeparture);
              },
            );
           } else if (snapshot.hasError) {
              return Text("error \n${snapshot.error}");
          }
           return CircularProgressIndicator();
         },
       )
       )
    );
  }
}