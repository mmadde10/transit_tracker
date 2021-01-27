part of 'arrival_bloc.dart';

abstract class ArrivalState extends Equatable {
  const ArrivalState();
  
  @override
  List<Object> get props => [];
}

class ArrivalInitial extends ArrivalState {}
