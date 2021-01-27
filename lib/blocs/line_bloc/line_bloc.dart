import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:transit_tracker/repositories/repositories.dart';
import 'package:transit_tracker/models/models.dart';
import 'package:transit_tracker/blocs/blocs.dart';


class LineBloc extends Bloc<LineEvent, LineState> {
  final LineRepository lineRepository;

    LineBloc({@required this.lineRepository})
      : assert(lineRepository != null),
      super(LineInitial());


  @override
  Stream<LineState> mapEventToState(LineEvent event) async* {
    if (event is LineRequested) {
      yield LineLoadInProgress();
      try {
        print("hello");
        List<Line> lines = await LineRepository.getLines();
        yield LineLoadSuccess(lines: lines);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }
  }

    Stream<LineState> _mapFetchWeatherToState(FetchLine event) async* {
    yield WeatherLoading();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield WeatherError();
    }
  }
}