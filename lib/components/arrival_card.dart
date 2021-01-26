import 'package:flutter/material.dart';


var colorAbrv = {
  "Red": Color(0xFFC60C30),
  "Blue": Color(0xFF00A1DE),
  "Brn": Color(0xFF62361B),
  "G": Color(0xFF009B3A),
  "Org": Color(0xFFF9461C),
  "Pink":Color(0xFFE27EA6),
  "P": Color(0xFF522398),
  "Y": Color(0xFFF9E300)
};


class ArrivalCard extends StatelessWidget{
  final String arrivalTime;
  final String destinationName;
  final String predictedTime;
  final String stationDeparture;
  final String routeColor;
  final String isApproaching;
  final String isDelayed;

  ArrivalCard(this.arrivalTime, this.destinationName, this.predictedTime, this.stationDeparture, this.routeColor, this.isApproaching, this.isDelayed);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 1.5,
      color: colorAbrv[routeColor],
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.fromLTRB(00.0,15.0,8.0,8.0),
              child: new Center(
                child: new Text(
                    calculateArrivalTime(isApproaching, arrivalTime, predictedTime),
                    style: new TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    )
                ),
              )
          ),
          new Padding(padding: new EdgeInsets.fromLTRB(0.0,0.0,0.0,8.0),
              child: new Center(
                  child: new Text(
                      handleTrainStatus(isApproaching, isDelayed),
                      style: new TextStyle(
                        fontSize: 20.0,
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
                      fontSize: 15.0,
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


String calculateArrivalTime(String isApproaching, String arrivalTime, String predictedTime){
  DateTime parsedArrivalTime = DateTime.parse(arrivalTime);
  DateTime parsedPredictedTime = DateTime.parse(predictedTime);
  int appr = int.parse(isApproaching);

  Duration calculatedArrivalTime = parsedArrivalTime.difference(parsedPredictedTime);
  
  String displayTime = calculatedArrivalTime.inMinutes.toString();

  if(appr == 1){
    displayTime = "Due";
  }
  
  
  return displayTime;
}

String handleTrainStatus(String isApproaching, String isDelayed){
  int appr = int.parse(isApproaching);
  int delayed = int.parse(isDelayed);
  
  String displayTimeUnits = " ";
  if(appr == 1){
    displayTimeUnits = " ";
  }
  else if(delayed == 1){
    displayTimeUnits = "Delayed";
  }
  else{
    displayTimeUnits = "Minutes";
  }

  return displayTimeUnits;
}