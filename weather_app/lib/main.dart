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
      Map<String, dynamic>? fetchData = await fetchWeatherData(-33.79, 18.52);
      setState(() {
        currentWeather = fetchData;
      });
      print(currentWeather);
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, dynamic>> forecastData = [];

  @override
  void initState() {
    super.initState();

    Map<String, dynamic>? forecastDataSample = {
      "cod": "200",
      "message": 0,
      "cnt": 40,
      "list": [
        {
          "dt": 1693148400,
          "main": {
            "temp": 299.22,
            "feels_like": 299.22,
            "temp_min": 299.22,
            "temp_max": 301.2,
            "pressure": 1005,
            "sea_level": 1005,
            "grnd_level": 924,
            "humidity": 62,
            "temp_kf": -1.98
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.03, "deg": 193, "gust": 5.01},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-27 15:00:00"
        },
        {
          "dt": 1693159200,
          "main": {
            "temp": 298.16,
            "feels_like": 298.28,
            "temp_min": 296.05,
            "temp_max": 298.16,
            "pressure": 1005,
            "sea_level": 1005,
            "grnd_level": 923,
            "humidity": 60,
            "temp_kf": 2.11
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 96},
          "wind": {"speed": 1.3, "deg": 256, "gust": 2.62},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-27 18:00:00"
        },
        {
          "dt": 1693170000,
          "main": {
            "temp": 295.41,
            "feels_like": 295.31,
            "temp_min": 293.5,
            "temp_max": 295.41,
            "pressure": 1004,
            "sea_level": 1004,
            "grnd_level": 921,
            "humidity": 62,
            "temp_kf": 1.91
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 99},
          "wind": {"speed": 0.62, "deg": 44, "gust": 1.85},
          "visibility": 10000,
          "pop": 0.07,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-27 21:00:00"
        },
        {
          "dt": 1693180800,
          "main": {
            "temp": 290.92,
            "feels_like": 290.71,
            "temp_min": 290.92,
            "temp_max": 290.92,
            "pressure": 1003,
            "sea_level": 1003,
            "grnd_level": 920,
            "humidity": 75,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 99},
          "wind": {"speed": 1.57, "deg": 188, "gust": 2.22},
          "visibility": 10000,
          "pop": 0.52,
          "rain": {"3h": 0.17},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-28 00:00:00"
        },
        {
          "dt": 1693191600,
          "main": {
            "temp": 289.02,
            "feels_like": 289.06,
            "temp_min": 289.02,
            "temp_max": 289.02,
            "pressure": 1002,
            "sea_level": 1002,
            "grnd_level": 918,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 93},
          "wind": {"speed": 1.08, "deg": 194, "gust": 2.32},
          "visibility": 10000,
          "pop": 0.88,
          "rain": {"3h": 0.68},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-28 03:00:00"
        },
        {
          "dt": 1693202400,
          "main": {
            "temp": 289.7,
            "feels_like": 289.76,
            "temp_min": 289.7,
            "temp_max": 289.7,
            "pressure": 1000,
            "sea_level": 1000,
            "grnd_level": 917,
            "humidity": 90,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 85},
          "wind": {"speed": 2.97, "deg": 141, "gust": 8.61},
          "visibility": 10000,
          "pop": 0.92,
          "rain": {"3h": 1.27},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-28 06:00:00"
        },
        {
          "dt": 1693213200,
          "main": {
            "temp": 293.05,
            "feels_like": 292.85,
            "temp_min": 293.05,
            "temp_max": 293.05,
            "pressure": 1000,
            "sea_level": 1000,
            "grnd_level": 918,
            "humidity": 67,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 77},
          "wind": {"speed": 4.52, "deg": 161, "gust": 9.52},
          "visibility": 10000,
          "pop": 0.73,
          "rain": {"3h": 0.4},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-28 09:00:00"
        },
        {
          "dt": 1693224000,
          "main": {
            "temp": 293.55,
            "feels_like": 293.34,
            "temp_min": 293.55,
            "temp_max": 293.55,
            "pressure": 999,
            "sea_level": 999,
            "grnd_level": 917,
            "humidity": 65,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 57},
          "wind": {"speed": 5.41, "deg": 165, "gust": 10.89},
          "visibility": 10000,
          "pop": 0.76,
          "rain": {"3h": 0.91},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-28 12:00:00"
        },
        {
          "dt": 1693234800,
          "main": {
            "temp": 294.5,
            "feels_like": 293.94,
            "temp_min": 294.5,
            "temp_max": 294.5,
            "pressure": 997,
            "sea_level": 997,
            "grnd_level": 916,
            "humidity": 48,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 801,
              "main": "Clouds",
              "description": "few clouds",
              "icon": "02d"
            }
          ],
          "clouds": {"all": 12},
          "wind": {"speed": 5.5, "deg": 183, "gust": 10.37},
          "visibility": 10000,
          "pop": 0.36,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-28 15:00:00"
        },
        {
          "dt": 1693245600,
          "main": {
            "temp": 286.74,
            "feels_like": 286.56,
            "temp_min": 286.74,
            "temp_max": 286.74,
            "pressure": 1000,
            "sea_level": 1000,
            "grnd_level": 916,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 41},
          "wind": {"speed": 1.46, "deg": 328, "gust": 3.3},
          "visibility": 10000,
          "pop": 0.6,
          "rain": {"3h": 1.28},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-28 18:00:00"
        },
        {
          "dt": 1693256400,
          "main": {
            "temp": 286.13,
            "feels_like": 285.96,
            "temp_min": 286.13,
            "temp_max": 286.13,
            "pressure": 1000,
            "sea_level": 1000,
            "grnd_level": 916,
            "humidity": 95,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.87, "deg": 340, "gust": 3.31},
          "visibility": 9871,
          "pop": 0.8,
          "rain": {"3h": 1.69},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-28 21:00:00"
        },
        {
          "dt": 1693267200,
          "main": {
            "temp": 285.3,
            "feels_like": 285,
            "temp_min": 285.3,
            "temp_max": 285.3,
            "pressure": 1000,
            "sea_level": 1000,
            "grnd_level": 916,
            "humidity": 93,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 2.05, "deg": 317, "gust": 3.94},
          "visibility": 8593,
          "pop": 0.8,
          "rain": {"3h": 0.46},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-29 00:00:00"
        },
        {
          "dt": 1693278000,
          "main": {
            "temp": 284.21,
            "feels_like": 283.77,
            "temp_min": 284.21,
            "temp_max": 284.21,
            "pressure": 1001,
            "sea_level": 1001,
            "grnd_level": 916,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.79, "deg": 305, "gust": 4.34},
          "visibility": 10000,
          "pop": 0.57,
          "rain": {"3h": 0.32},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-29 03:00:00"
        },
        {
          "dt": 1693288800,
          "main": {
            "temp": 284.16,
            "feels_like": 283.74,
            "temp_min": 284.16,
            "temp_max": 284.16,
            "pressure": 1001,
            "sea_level": 1001,
            "grnd_level": 917,
            "humidity": 93,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.78, "deg": 318, "gust": 4.19},
          "visibility": 10000,
          "pop": 0.45,
          "rain": {"3h": 0.1},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-29 06:00:00"
        },
        {
          "dt": 1693299600,
          "main": {
            "temp": 284.43,
            "feels_like": 284.02,
            "temp_min": 284.43,
            "temp_max": 284.43,
            "pressure": 1003,
            "sea_level": 1003,
            "grnd_level": 918,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 2.46, "deg": 316, "gust": 4.48},
          "visibility": 10000,
          "pop": 0.52,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-29 09:00:00"
        },
        {
          "dt": 1693310400,
          "main": {
            "temp": 284.59,
            "feels_like": 284.09,
            "temp_min": 284.59,
            "temp_max": 284.59,
            "pressure": 1003,
            "sea_level": 1003,
            "grnd_level": 919,
            "humidity": 88,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 2.18, "deg": 299, "gust": 3.76},
          "visibility": 10000,
          "pop": 0.76,
          "rain": {"3h": 0.3},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-29 12:00:00"
        },
        {
          "dt": 1693321200,
          "main": {
            "temp": 284.13,
            "feels_like": 283.79,
            "temp_min": 284.13,
            "temp_max": 284.13,
            "pressure": 1003,
            "sea_level": 1003,
            "grnd_level": 919,
            "humidity": 96,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.63, "deg": 303, "gust": 3.11},
          "visibility": 6335,
          "pop": 1,
          "rain": {"3h": 5.54},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-29 15:00:00"
        },
        {
          "dt": 1693332000,
          "main": {
            "temp": 284.3,
            "feels_like": 283.98,
            "temp_min": 284.3,
            "temp_max": 284.3,
            "pressure": 1004,
            "sea_level": 1004,
            "grnd_level": 919,
            "humidity": 96,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.99, "deg": 301, "gust": 4.83},
          "visibility": 9197,
          "pop": 1,
          "rain": {"3h": 3.58},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-29 18:00:00"
        },
        {
          "dt": 1693342800,
          "main": {
            "temp": 284.01,
            "feels_like": 283.66,
            "temp_min": 284.01,
            "temp_max": 284.01,
            "pressure": 1006,
            "sea_level": 1006,
            "grnd_level": 920,
            "humidity": 96,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "clouds": {"all": 95},
          "wind": {"speed": 1.34, "deg": 309, "gust": 2.83},
          "visibility": 10000,
          "pop": 0.51,
          "rain": {"3h": 0.18},
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-29 21:00:00"
        },
        {
          "dt": 1693353600,
          "main": {
            "temp": 284.27,
            "feels_like": 283.89,
            "temp_min": 284.27,
            "temp_max": 284.27,
            "pressure": 1006,
            "sea_level": 1006,
            "grnd_level": 921,
            "humidity": 94,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 96},
          "wind": {"speed": 1.41, "deg": 280, "gust": 2.16},
          "visibility": 10000,
          "pop": 0.43,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-30 00:00:00"
        },
        {
          "dt": 1693364400,
          "main": {
            "temp": 284.77,
            "feels_like": 284.39,
            "temp_min": 284.77,
            "temp_max": 284.77,
            "pressure": 1005,
            "sea_level": 1005,
            "grnd_level": 921,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 0.87, "deg": 305, "gust": 1.64},
          "visibility": 10000,
          "pop": 0.11,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-30 03:00:00"
        },
        {
          "dt": 1693375200,
          "main": {
            "temp": 284.38,
            "feels_like": 284.01,
            "temp_min": 284.38,
            "temp_max": 284.38,
            "pressure": 1006,
            "sea_level": 1006,
            "grnd_level": 921,
            "humidity": 94,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.16, "deg": 322, "gust": 1.72},
          "visibility": 10000,
          "pop": 0.28,
          "rain": {"3h": 0.56},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-30 06:00:00"
        },
        {
          "dt": 1693386000,
          "main": {
            "temp": 284.86,
            "feels_like": 284.49,
            "temp_min": 284.86,
            "temp_max": 284.86,
            "pressure": 1008,
            "sea_level": 1008,
            "grnd_level": 923,
            "humidity": 92,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 0.84, "deg": 325, "gust": 1.59},
          "visibility": 10000,
          "pop": 0.28,
          "rain": {"3h": 0.22},
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-30 09:00:00"
        },
        {
          "dt": 1693396800,
          "main": {
            "temp": 286.18,
            "feels_like": 285.73,
            "temp_min": 286.18,
            "temp_max": 286.18,
            "pressure": 1009,
            "sea_level": 1009,
            "grnd_level": 924,
            "humidity": 84,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 0.78, "deg": 0, "gust": 1.29},
          "visibility": 10000,
          "pop": 0.37,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-30 12:00:00"
        },
        {
          "dt": 1693407600,
          "main": {
            "temp": 288.55,
            "feels_like": 287.97,
            "temp_min": 288.55,
            "temp_max": 288.55,
            "pressure": 1009,
            "sea_level": 1009,
            "grnd_level": 925,
            "humidity": 70,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 2.38, "deg": 26, "gust": 2.42},
          "visibility": 10000,
          "pop": 0.17,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-30 15:00:00"
        },
        {
          "dt": 1693418400,
          "main": {
            "temp": 284.61,
            "feels_like": 284.24,
            "temp_min": 284.61,
            "temp_max": 284.61,
            "pressure": 1010,
            "sea_level": 1010,
            "grnd_level": 925,
            "humidity": 93,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 1.24, "deg": 47, "gust": 1.58},
          "visibility": 10000,
          "pop": 0.17,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-30 18:00:00"
        },
        {
          "dt": 1693429200,
          "main": {
            "temp": 283.44,
            "feels_like": 282.98,
            "temp_min": 283.44,
            "temp_max": 283.44,
            "pressure": 1012,
            "sea_level": 1012,
            "grnd_level": 927,
            "humidity": 94,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 91},
          "wind": {"speed": 0.67, "deg": 243, "gust": 0.98},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-30 21:00:00"
        },
        {
          "dt": 1693440000,
          "main": {
            "temp": 283.08,
            "feels_like": 283.08,
            "temp_min": 283.08,
            "temp_max": 283.08,
            "pressure": 1013,
            "sea_level": 1013,
            "grnd_level": 927,
            "humidity": 93,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 52},
          "wind": {"speed": 0.94, "deg": 227, "gust": 1.08},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-31 00:00:00"
        },
        {
          "dt": 1693450800,
          "main": {
            "temp": 283.02,
            "feels_like": 283.02,
            "temp_min": 283.02,
            "temp_max": 283.02,
            "pressure": 1014,
            "sea_level": 1014,
            "grnd_level": 928,
            "humidity": 93,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01n"
            }
          ],
          "clouds": {"all": 3},
          "wind": {"speed": 1, "deg": 226, "gust": 0.99},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-31 03:00:00"
        },
        {
          "dt": 1693461600,
          "main": {
            "temp": 285.3,
            "feels_like": 284.79,
            "temp_min": 285.3,
            "temp_max": 285.3,
            "pressure": 1016,
            "sea_level": 1016,
            "grnd_level": 930,
            "humidity": 85,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 802,
              "main": "Clouds",
              "description": "scattered clouds",
              "icon": "03d"
            }
          ],
          "clouds": {"all": 32},
          "wind": {"speed": 0.64, "deg": 246, "gust": 0.86},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-31 06:00:00"
        },
        {
          "dt": 1693472400,
          "main": {
            "temp": 290.57,
            "feels_like": 289.88,
            "temp_min": 290.57,
            "temp_max": 290.57,
            "pressure": 1017,
            "sea_level": 1017,
            "grnd_level": 932,
            "humidity": 58,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 97},
          "wind": {"speed": 2.35, "deg": 9, "gust": 2.53},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-31 09:00:00"
        },
        {
          "dt": 1693483200,
          "main": {
            "temp": 293.55,
            "feels_like": 292.98,
            "temp_min": 293.55,
            "temp_max": 293.55,
            "pressure": 1016,
            "sea_level": 1016,
            "grnd_level": 933,
            "humidity": 51,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 97},
          "wind": {"speed": 2.7, "deg": 21, "gust": 2.21},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-31 12:00:00"
        },
        {
          "dt": 1693494000,
          "main": {
            "temp": 293.77,
            "feels_like": 293.22,
            "temp_min": 293.77,
            "temp_max": 293.77,
            "pressure": 1016,
            "sea_level": 1016,
            "grnd_level": 933,
            "humidity": 51,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 74},
          "wind": {"speed": 2.47, "deg": 42, "gust": 1.94},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-08-31 15:00:00"
        },
        {
          "dt": 1693504800,
          "main": {
            "temp": 288.05,
            "feels_like": 287.55,
            "temp_min": 288.05,
            "temp_max": 288.05,
            "pressure": 1018,
            "sea_level": 1018,
            "grnd_level": 933,
            "humidity": 75,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 84},
          "wind": {"speed": 0.82, "deg": 75, "gust": 1.13},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-31 18:00:00"
        },
        {
          "dt": 1693515600,
          "main": {
            "temp": 286.35,
            "feels_like": 285.84,
            "temp_min": 286.35,
            "temp_max": 286.35,
            "pressure": 1020,
            "sea_level": 1020,
            "grnd_level": 934,
            "humidity": 81,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 91},
          "wind": {"speed": 1.61, "deg": 228, "gust": 1.49},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-08-31 21:00:00"
        },
        {
          "dt": 1693526400,
          "main": {
            "temp": 285.53,
            "feels_like": 285.02,
            "temp_min": 285.53,
            "temp_max": 285.53,
            "pressure": 1020,
            "sea_level": 1020,
            "grnd_level": 934,
            "humidity": 84,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 75},
          "wind": {"speed": 1.46, "deg": 230, "gust": 1.36},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-09-01 00:00:00"
        },
        {
          "dt": 1693537200,
          "main": {
            "temp": 284.97,
            "feels_like": 284.48,
            "temp_min": 284.97,
            "temp_max": 284.97,
            "pressure": 1020,
            "sea_level": 1020,
            "grnd_level": 934,
            "humidity": 87,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01n"
            }
          ],
          "clouds": {"all": 9},
          "wind": {"speed": 1.37, "deg": 236, "gust": 1.28},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "n"},
          "dt_txt": "2023-09-01 03:00:00"
        },
        {
          "dt": 1693548000,
          "main": {
            "temp": 287.28,
            "feels_like": 286.81,
            "temp_min": 287.28,
            "temp_max": 287.28,
            "pressure": 1021,
            "sea_level": 1021,
            "grnd_level": 936,
            "humidity": 79,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "clouds": {"all": 4},
          "wind": {"speed": 0.91, "deg": 249, "gust": 0.96},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-09-01 06:00:00"
        },
        {
          "dt": 1693558800,
          "main": {
            "temp": 293.09,
            "feels_like": 292.58,
            "temp_min": 293.09,
            "temp_max": 293.09,
            "pressure": 1021,
            "sea_level": 1021,
            "grnd_level": 937,
            "humidity": 55,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "clouds": {"all": 0},
          "wind": {"speed": 2.03, "deg": 23, "gust": 1.62},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-09-01 09:00:00"
        },
        {
          "dt": 1693569600,
          "main": {
            "temp": 296.13,
            "feels_like": 295.58,
            "temp_min": 296.13,
            "temp_max": 296.13,
            "pressure": 1020,
            "sea_level": 1020,
            "grnd_level": 937,
            "humidity": 42,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "clouds": {"all": 0},
          "wind": {"speed": 2.43, "deg": 28, "gust": 1.41},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2023-09-01 12:00:00"
        }
      ],
      "city": {
        "id": 3163858,
        "name": "Zocca",
        "coord": {"lat": 44.34, "lon": 10.99},
        "country": "IT",
        "population": 4593,
        "timezone": 7200,
        "sunrise": 1693110761,
        "sunset": 1693159390
      }
    };

    var forecastList = forecastDataSample['list'] as List;

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

        // String dayOfWeek = date.weekday.toString();
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 1 * fem),
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
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 1 * fem),
                                            child: Flexible(
                                              child: Text(
                                                ((currentWeather?['main']
                                                                    ['temp'] ??
                                                                -273.15) -
                                                            273.15)
                                                        .toStringAsFixed(1) +
                                                    "°C",
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
                                            'current',
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
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 1 * fem),
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
                                            'max',
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
                                              height: 1.2660000059 * ffem / fem,
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
                                              height: 1.2660000059 * ffem / fem,
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
                                              height: 1.2660000059 * ffem / fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )),
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
