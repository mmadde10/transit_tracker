import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'arrival_event.dart';
part 'arrival_state.dart';

class ArrivalBloc extends Bloc<ArrivalEvent, ArrivalState> {
  ArrivalBloc() : super(ArrivalInitial());

  @override
  Stream<ArrivalState> mapEventToState(
    ArrivalEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
