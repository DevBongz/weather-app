import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? currentWeather;
  List<Map<String, dynamic>> forecastData = [];

  static const String apiKey = "962fe95f870ebae67169f725a80ffd61";

  Future<Map<String, dynamic>> fetchWeatherData(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchForecastData(double lat, double lng) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lng&appid=$apiKey"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  _loadWeather() async {
    try {
      Map<String, dynamic>? fetchData = await fetchWeatherData(-33.79, 18.52);
      setState(() {
        currentWeather = fetchData;
      });
      print(currentWeather);

      // Fetching forecast data
      Map<String, dynamic> fetchedForecastData =
          await fetchForecastData(-33.79, 18.52);

      var forecastList = fetchedForecastData['list'] as List;

      for (var forecast in forecastList) {
        String dateText = forecast['dt_txt'];
        if (dateText.endsWith('15:00:00')) {
          DateTime date = DateTime.parse(dateText);

          List<String> daysOfWeek = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ];

          String dayOfWeek = daysOfWeek[date.weekday - 1];
          String weatherDescription = forecast['weather'][0]['description'];
          double tempMax = forecast['main']['temp_max'] -
              273.15; // Convert from Kelvin to Celsius

          forecastData.add({
            'day': dayOfWeek,
            'description': weatherDescription,
            'tempMax': tempMax.toStringAsFixed(1) + "°C"
          });

          print(forecastData);
        }
      }

      setState(() {
        forecastData = forecastData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            _loadWeather();
          },
          child: const Icon(Icons.refresh),
        ),
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: 932 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(15 * fem),
              ),
              child: Stack(
                children: [
                  if (currentWeather != null)
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 430 * fem,
                          height: 382.22 * fem,
                          child: Image.asset(
                            'assets/page-1/images/seasunnypng-1.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 111 * fem,
                    top: 84 * fem,
                    child: Container(
                      width: 217 * fem,
                      height: 120 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 6 * fem),
                              child: Flexible(
                                child: Text(
                                  ((currentWeather?['main']['temp'] ?? 273.15) -
                                              273.15)
                                          .toStringAsFixed(1) +
                                      "°C",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 49 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2660000081 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              (currentWeather?['weather'][0]['description'] ??
                                  'Loading...'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 35 * ffem,
                                fontWeight: FontWeight.w300,
                                height: 1.2660000392 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0 * fem,
                    top: 372 * fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          1 * fem, 46 * fem, 0 * fem, 44 * fem),
                      width: 431 * fem,
                      height: 560 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff4a90e2),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15 * fem),
                          bottomLeft: Radius.circular(15 * fem),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  39 * fem, 0 * fem, 41 * fem, 32 * fem),
                              width: double.infinity,
                              height: 5 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              child: Flexible(
                                                child: Text(
                                                  ((currentWeather?['main'][
                                                                      'temp_min'] ??
                                                                  273.15) -
                                                              273.15)
                                                          .toStringAsFixed(1) +
                                                      "°C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.2660000059 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'min',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w300,
                                                height:
                                                    1.2660000059 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50 * fem,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              child: Flexible(
                                                child: Text(
                                                  ((currentWeather?['main'][
                                                                      'temp'] ??
                                                                  -273.15) -
                                                              273.15)
                                                          .toStringAsFixed(1) +
                                                      "°C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.2660000059 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'current',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w300,
                                                height:
                                                    1.2660000059 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50 * fem,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              child: Flexible(
                                                child: Text(
                                                  ((currentWeather?['main'][
                                                                      'temp_max'] ??
                                                                  -273.15) -
                                                              273.15)
                                                          .toStringAsFixed(1) +
                                                      "°C",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.2660000059 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'max',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w300,
                                                height:
                                                    1.2660000059 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 33 * fem),
                              width: double.infinity,
                              height: 3 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    31 * fem, 0 * fem, 42 * fem, 0 * fem),
                                width: double.infinity,
                                child: Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: forecastData.map((data) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                data['day'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18 * ffem,
                                                  fontWeight: FontWeight.w300,
                                                  height:
                                                      1.2660000059 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Flexible(
                                              child: Text(
                                                data['description'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18 * ffem,
                                                  fontWeight: FontWeight.w300,
                                                  height:
                                                      1.2660000059 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Flexible(
                                              child: Text(
                                                data['tempMax'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18 * ffem,
                                                  fontWeight: FontWeight.w300,
                                                  height:
                                                      1.2660000059 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
