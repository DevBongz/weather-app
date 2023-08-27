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

  _loadWeather() async {
    try {
      Map<String, dynamic>? fetchData = await fetchWeatherData(33.81, 18.49);
      setState(() {
        currentWeather = fetchData;
      });
      print(currentWeather);
    } catch (e) {
      print(e);
    }
  }

  // Map<String, dynamic> currentWeather = {
  //   "coord": {"lon": 18.49, "lat": 33.81},
  //   "weather": [
  //     {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
  //   ],
  //   "base": "stations",
  //   "main": {
  //     "temp": 300.6,
  //     "feels_like": 303.8,
  //     "temp_min": 300.6,
  //     "temp_max": 300.6,
  //     "pressure": 1013,
  //     "humidity": 79,
  //     "sea_level": 1013,
  //     "grnd_level": 1013
  //   },
  //   "visibility": 10000,
  //   "wind": {"speed": 3.16, "deg": 314, "gust": 3.84},
  //   "clouds": {"all": 0},
  //   "dt": 1693069237,
  //   "sys": {"sunrise": 1693023329, "sunset": 1693070456},
  //   "timezone": 3600,
  //   "id": 0,
  //   "name": "",
  //   "cod": 200
  // };

  Map<String, dynamic>? forecast;

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
                                  (currentWeather?['main']['temp'] ??
                                          'Loading...')
                                      .toString(),
                                  // currentWeather!['main']['temp'].toString(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                39 * fem, 0 * fem, 41 * fem, 32 * fem),
                            width: double.infinity,
                            height: 48 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 6 * fem),
                                          child: Flexible(
                                            child: Text(
                                              '19',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2660000059 * ffem / fem,
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
                                            height: 1.2660000059 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 116.5 * fem,
                                ),
                                Container(
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 6 * fem),
                                          child: Flexible(
                                            child: Text(
                                              '19',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2660000059 * ffem / fem,
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
                                            height: 1.2660000059 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 116.5 * fem,
                                ),
                                Container(
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 6 * fem),
                                          child: Flexible(
                                            child: Text(
                                              '19',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2660000059 * ffem / fem,
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
                                            height: 1.2660000059 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1-37P.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24 * fem,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1-zSD.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24 * fem,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1-Fh3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24 * fem,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24 * fem,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1-moP.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24 * fem,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Tuesday',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Container(
                                        width: 39 * fem,
                                        height: 39 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/clear3x-1-wYu.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95 * fem,
                                      ),
                                      Text(
                                        '20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2660000059 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

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
}
