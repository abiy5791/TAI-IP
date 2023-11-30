import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';


import 'package:geolocator/geolocator.dart';


import 'package:weather/weather.dart';


import 'package:weather_app/data/my_data.dart';


part 'weather_event.dart';


part 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherBloc() : super(WeatherInitial()) {

    on<FetchWeatherData>((event, emit) async {

      emit(WeatherBlocLoading());


      try {

        WeatherFactory wf = WeatherFactory(Api_Key, language: Language.ENGLISH);


        Weather weather = await wf.currentWeatherByLocation(

            event.position.latitude, event.position.longitude);


        emit(WeatherBlocSuccess(weather));

      } catch (e) {

        emit(WeatherBlocFailed());

      }

    });

  }

}

