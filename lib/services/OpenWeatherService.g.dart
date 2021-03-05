// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenWeatherService.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) {
  return WeatherInfo(
    main: json['main'] == null
        ? null
        : MainWeatherInfo.fromJson(json['main'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'main': instance.main?.toJson(),
      'name': instance.name,
    };

MainWeatherInfo _$MainWeatherInfoFromJson(Map<String, dynamic> json) {
  return MainWeatherInfo(
    temp: (json['temp'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MainWeatherInfoToJson(MainWeatherInfo instance) =>
    <String, dynamic>{
      'temp': instance.temp,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OpenWeatherService implements OpenWeatherService {
  _OpenWeatherService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://api.openweathermap.org/data/2.5/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<WeatherInfo> getWeatherByCityName(cityName, apiKey, units) async {
    ArgumentError.checkNotNull(cityName, 'cityName');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(units, 'units');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'q': cityName,
      r'appid': apiKey,
      r'units': units
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/weather',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = WeatherInfo.fromJson(_result.data);
    return value;
  }
}
