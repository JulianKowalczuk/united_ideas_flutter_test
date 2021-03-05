import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dio/dio.dart';

import 'package:united_ideas_flutter_test/screens/CityWeatherScreen.dart';
import 'package:united_ideas_flutter_test/services/OpenWeatherService.dart';

var suggestionsToStoreMaxCount = 10;

class SearchCityScreen extends HookWidget {
  const SearchCityScreen();

  void handleSearchFieldError(
    BuildContext context,
    DioError error,
    TextEditingController searchFieldController,
  ) {
    if (error.response.statusCode == 404) {
      searchFieldController.text = '';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'We cannot find provided city',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var searchFieldController = useTextEditingController();
    var isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(title: Text('Search city')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: Hive.box('searchedCities').listenable(),
            builder: (context, box, widget) {
              var cities = box
                  .get('searchCityScreenCities', defaultValue: [])
                  .cast<String>()
                  .toList();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchField(
                    controller: searchFieldController,
                    suggestions: cities,
                  ),
                  SizedBox(height: 50),
                  isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            isLoading.value = true;

                            try {
                              var cityNameFromField =
                                  searchFieldController.text;

                              var weatherInfo =
                                  await getWeatherInCelciusByCityName(
                                      cityNameFromField);

                              await box.put(
                                'searchCityScreenCities',
                                {...cities, weatherInfo.name}
                                    .toList()
                                    .take(suggestionsToStoreMaxCount)
                                    .toList(),
                              );

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CityWeatherScreen(
                                    cityName: cityNameFromField,
                                    temperature: weatherInfo.main.temp,
                                  ),
                                ),
                              );
                            } on DioError catch (error) {
                              handleSearchFieldError(
                                  context, error, searchFieldController);
                            }

                            isLoading.value = false;
                          },
                        )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
