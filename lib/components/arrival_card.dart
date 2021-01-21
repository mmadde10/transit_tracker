import 'package:flutter/material.dart';


class ArrivalCard extends StatelessWidget{
  final String arrivalTime;
  final String destinationName;
  final String predictedTime;
  final String stationDeparture;

  ArrivalCard(this.arrivalTime, this.destinationName, this.predictedTime, this.stationDeparture);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 1.5,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.fromLTRB(00.0,25.0,8.0,8.0),
              child: new Center(
                child: new Text(
                    calculateArrivalTime(arrivalTime, predictedTime),
                    style: new TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    )
                ),
              )
          ),
          new Padding(padding: new EdgeInsets.fromLTRB(0.0,0.0,0.0,8.0),
              child: new Center(
                  child: new Text(
                      "Minutes", 
                      style: new TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )
                  )
              ),
          ),
          new Padding(
              padding: new EdgeInsets.fromLTRB(0.0,70.0,0.0,0.0),
            child: new Center(
              child: new Text(
                    destinationName,
                    style: new TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    )
                )
            )
          )
        ],
      )
    );
  }
}


String calculateArrivalTime(String arrivalTime, String predictedTime){
  DateTime parsedArrivalTime = DateTime.parse(arrivalTime);
  DateTime parsedPredictedTime = DateTime.parse(predictedTime);

  Duration calculatedArrivalTime = parsedArrivalTime.difference(parsedPredictedTime);
  
  String displayTime = calculatedArrivalTime.inMinutes.toString();
  
  return displayTime;
}