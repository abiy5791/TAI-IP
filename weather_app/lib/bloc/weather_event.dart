part of 'weather_bloc.dart';


sealed class WeatherEvent extends Equatable {

  const WeatherEvent();


  @override

  List<Object> get props => [];

}


class FetchWeatherData extends WeatherEvent {

  final Position position;

  const FetchWeatherData(this.position);

  @override

  List<Object> get props => [position];

}

