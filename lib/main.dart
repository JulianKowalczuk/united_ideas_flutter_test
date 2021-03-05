import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:united_ideas_flutter_test/screens/SearchCityScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dot_env.load(fileName: '.env');

  await Hive.initFlutter();
  await Hive.openBox('searchedCities');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unites Ideas Flutter Test',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const SearchCityScreen(),
    );
  }
}
