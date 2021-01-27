import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LineEvent extends Equatable {
  const LineEvent();
}

class LineRequested extends LineEvent {

  const LineRequested();

  @override
  List<Object> get props => [];
}