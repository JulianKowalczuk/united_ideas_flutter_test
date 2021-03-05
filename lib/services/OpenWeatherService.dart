import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'OpenWeatherService.g.dart';

@RestApi(baseUrl: 'http://api.openweathermap.org/data/2.5/')
abstract class OpenWeatherService {
  factory OpenWeatherService(Dio dio, {String baseUrl}) = _OpenWeatherService;

  @GET('/weather')
  Future<WeatherInfo> getWeatherByCityName(
    @Query('q') String cityName,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );
}

var dio = Dio();

var _openWeatherService = OpenWeatherService(dio);

Future<WeatherInfo> getWeatherInCelciusByCityName(String cityName) {
  return _openWeatherService.getWeatherByCityName(
    cityName,
    env['WEATHER_API_KEY'],
    'metric',
  );
}

@JsonSerializable()
class WeatherInfo {
  MainWeatherInfo main;
  String name;

  WeatherInfo({this.main, this.name});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

@JsonSerializable()
class MainWeatherInfo {
  double temp;

  MainWeatherInfo({this.temp});

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MainWeatherInfoToJson(this);
}
