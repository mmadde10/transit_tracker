import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LineEvent extends Equatable {
  const LineEvent();
}

class LineRequested extends LineEvent {
  final String city;

  const LineRequested({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}