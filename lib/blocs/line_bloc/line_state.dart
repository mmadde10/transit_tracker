import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:transit_tracker/models/models.dart';

abstract class LineState extends Equatable {
  const LineState();

  @override
  List<Object> get props => [];
}

class LineInitial extends LineState {}

class LineLoadInProgress extends LineState {}

class LineEmpty extends LineState {}


class LineLoadSuccess extends LineState {
  final List<Line> lines;

  const LineLoadSuccess({@required this.lines}) : assert(lines != null);

  @override
  List<Object> get props => [lines];
}

class WeatherLoadFailure extends LineState {}