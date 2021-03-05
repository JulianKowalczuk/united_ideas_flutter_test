import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CityWeatherScreen extends HookWidget {
  final String cityName;
  final double temperature;

  CityWeatherScreen({@required this.cityName, @required this.temperature});

  Color getTemperatureColor() {
    if (temperature < 10) return Colors.blue;

    if (temperature > 20) return Colors.red;

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    var temperatureColor = useMemoized(getTemperatureColor, [temperature]);

    return Scaffold(
      appBar: AppBar(title: Text('$cityName weather')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temperature.toStringAsFixed(0) + ' °C',
              style: TextStyle(fontSize: 120, color: temperatureColor),
            ),
          ],
        ),
      ),
    );
  }
}
