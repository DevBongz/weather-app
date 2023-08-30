import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

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

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

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
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return; // If permission is still not granted, return.
        }
      }

      _locationData = await location.getLocation();

      Map<String, dynamic>? fetchData = {
        "coord": {"lon": 18.49, "lat": 33.81},
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02n"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 299.3,
          "feels_like": 299.3,
          "temp_min": 299.3,
          "temp_max": 299.3,
          "pressure": 1011,
          "humidity": 57,
          "sea_level": 1011,
          "grnd_level": 1011
        },
        "visibility": 10000,
        "wind": {"speed": 5.29, "deg": 333, "gust": 5.59},
        "clouds": {"all": 12},
        "dt": 1693353717,
        "sys": {"sunrise": 1693369095, "sunset": 1693415750},
        "timezone": 3600,
        "id": 0,
        "name": "",
        "cod": 200
      };
      // await fetchWeatherData(
      //     _locationData.latitude!, _locationData.longitude!);
      setState(() {
        currentWeather = fetchData;
      });
      print(" Current Weather: " + currentWeather.toString());

      // Fetching forecast data
      Map<String, dynamic> fetchedForecastData = {
        "cod": "200",
        "message": 0,
        "cnt": 40,
        "list": [
          {
            "dt": 1693353600,
            "main": {
              "temp": 286.18,
              "feels_like": 285.76,
              "temp_min": 285.73,
              "temp_max": 286.18,
              "pressure": 1005,
              "sea_level": 1005,
              "grnd_level": 921,
              "humidity": 85,
              "temp_kf": 0.45
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 92},
            "wind": {"speed": 1.09, "deg": 327, "gust": 1.2},
            "visibility": 10000,
            "pop": 0.25,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-30 00:00:00"
          },
          {
            "dt": 1693364400,
            "main": {
              "temp": 285.49,
              "feels_like": 285.05,
              "temp_min": 285.04,
              "temp_max": 285.49,
              "pressure": 1006,
              "sea_level": 1006,
              "grnd_level": 921,
              "humidity": 87,
              "temp_kf": 0.45
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
            "wind": {"speed": 1.11, "deg": 329, "gust": 1.44},
            "visibility": 10000,
            "pop": 0.16,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-30 03:00:00"
          },
          {
            "dt": 1693375200,
            "main": {
              "temp": 285.31,
              "feels_like": 284.83,
              "temp_min": 285.31,
              "temp_max": 285.31,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 922,
              "humidity": 86,
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
            "clouds": {"all": 99},
            "wind": {"speed": 0.54, "deg": 291, "gust": 0.91},
            "visibility": 10000,
            "pop": 0.12,
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-30 06:00:00"
          },
          {
            "dt": 1693386000,
            "main": {
              "temp": 287.77,
              "feels_like": 287.22,
              "temp_min": 287.77,
              "temp_max": 287.77,
              "pressure": 1008,
              "sea_level": 1008,
              "grnd_level": 923,
              "humidity": 74,
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
            "clouds": {"all": 95},
            "wind": {"speed": 1.52, "deg": 355, "gust": 1.78},
            "visibility": 10000,
            "pop": 0.04,
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-30 09:00:00"
          },
          {
            "dt": 1693396800,
            "main": {
              "temp": 292.53,
              "feels_like": 291.86,
              "temp_min": 292.53,
              "temp_max": 292.53,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 924,
              "humidity": 51,
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
            "clouds": {"all": 79},
            "wind": {"speed": 2.8, "deg": 34, "gust": 3.13},
            "visibility": 10000,
            "pop": 0.34,
            "rain": {"3h": 0.37},
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-30 12:00:00"
          },
          {
            "dt": 1693407600,
            "main": {
              "temp": 291.19,
              "feels_like": 290.56,
              "temp_min": 291.19,
              "temp_max": 291.19,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 924,
              "humidity": 58,
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
            "clouds": {"all": 82},
            "wind": {"speed": 1.6, "deg": 71, "gust": 1.48},
            "visibility": 10000,
            "pop": 0.41,
            "rain": {"3h": 0.49},
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-30 15:00:00"
          },
          {
            "dt": 1693418400,
            "main": {
              "temp": 287.51,
              "feels_like": 286.86,
              "temp_min": 287.51,
              "temp_max": 287.51,
              "pressure": 1008,
              "sea_level": 1008,
              "grnd_level": 924,
              "humidity": 71,
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
            "clouds": {"all": 79},
            "wind": {"speed": 1.03, "deg": 123, "gust": 2.04},
            "visibility": 10000,
            "pop": 0.37,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-30 18:00:00"
          },
          {
            "dt": 1693429200,
            "main": {
              "temp": 285.29,
              "feels_like": 284.65,
              "temp_min": 285.29,
              "temp_max": 285.29,
              "pressure": 1010,
              "sea_level": 1010,
              "grnd_level": 925,
              "humidity": 80,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03n"
              }
            ],
            "clouds": {"all": 33},
            "wind": {"speed": 2.12, "deg": 203, "gust": 2.27},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-30 21:00:00"
          },
          {
            "dt": 1693440000,
            "main": {
              "temp": 284.81,
              "feels_like": 284.12,
              "temp_min": 284.81,
              "temp_max": 284.81,
              "pressure": 1011,
              "sea_level": 1011,
              "grnd_level": 926,
              "humidity": 80,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02n"
              }
            ],
            "clouds": {"all": 23},
            "wind": {"speed": 2.15, "deg": 213, "gust": 1.96},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-31 00:00:00"
          },
          {
            "dt": 1693450800,
            "main": {
              "temp": 284.15,
              "feels_like": 283.45,
              "temp_min": 284.15,
              "temp_max": 284.15,
              "pressure": 1012,
              "sea_level": 1012,
              "grnd_level": 926,
              "humidity": 82,
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
            "clouds": {"all": 2},
            "wind": {"speed": 1.93, "deg": 214, "gust": 1.73},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-31 03:00:00"
          },
          {
            "dt": 1693461600,
            "main": {
              "temp": 286.38,
              "feels_like": 285.59,
              "temp_min": 286.38,
              "temp_max": 286.38,
              "pressure": 1013,
              "sea_level": 1013,
              "grnd_level": 928,
              "humidity": 70,
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
            "clouds": {"all": 13},
            "wind": {"speed": 1.48, "deg": 217, "gust": 2.06},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-31 06:00:00"
          },
          {
            "dt": 1693472400,
            "main": {
              "temp": 292.85,
              "feels_like": 292.16,
              "temp_min": 292.85,
              "temp_max": 292.85,
              "pressure": 1014,
              "sea_level": 1014,
              "grnd_level": 931,
              "humidity": 49,
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
            "clouds": {"all": 59},
            "wind": {"speed": 0.9, "deg": 45, "gust": 1.45},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-31 09:00:00"
          },
          {
            "dt": 1693483200,
            "main": {
              "temp": 294.23,
              "feels_like": 293.73,
              "temp_min": 294.23,
              "temp_max": 294.23,
              "pressure": 1014,
              "sea_level": 1014,
              "grnd_level": 931,
              "humidity": 51,
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
            "clouds": {"all": 79},
            "wind": {"speed": 0.1, "deg": 140, "gust": 2.89},
            "visibility": 10000,
            "pop": 0.28,
            "rain": {"3h": 0.33},
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-31 12:00:00"
          },
          {
            "dt": 1693494000,
            "main": {
              "temp": 293.69,
              "feels_like": 293.13,
              "temp_min": 293.69,
              "temp_max": 293.69,
              "pressure": 1014,
              "sea_level": 1014,
              "grnd_level": 931,
              "humidity": 51,
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
            "clouds": {"all": 87},
            "wind": {"speed": 0.73, "deg": 52, "gust": 2.23},
            "visibility": 10000,
            "pop": 0.2,
            "rain": {"3h": 0.51},
            "sys": {"pod": "d"},
            "dt_txt": "2023-08-31 15:00:00"
          },
          {
            "dt": 1693504800,
            "main": {
              "temp": 288.12,
              "feels_like": 287.58,
              "temp_min": 288.12,
              "temp_max": 288.12,
              "pressure": 1015,
              "sea_level": 1015,
              "grnd_level": 931,
              "humidity": 73,
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
            "clouds": {"all": 80},
            "wind": {"speed": 1.87, "deg": 179, "gust": 3.07},
            "visibility": 10000,
            "pop": 0.04,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-31 18:00:00"
          },
          {
            "dt": 1693515600,
            "main": {
              "temp": 286.12,
              "feels_like": 285.56,
              "temp_min": 286.12,
              "temp_max": 286.12,
              "pressure": 1017,
              "sea_level": 1017,
              "grnd_level": 932,
              "humidity": 80,
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
            "clouds": {"all": 58},
            "wind": {"speed": 2.99, "deg": 212, "gust": 3.89},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-08-31 21:00:00"
          },
          {
            "dt": 1693526400,
            "main": {
              "temp": 285.37,
              "feels_like": 284.79,
              "temp_min": 285.37,
              "temp_max": 285.37,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 932,
              "humidity": 82,
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
            "clouds": {"all": 56},
            "wind": {"speed": 2.68, "deg": 211, "gust": 3.24},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-01 00:00:00"
          },
          {
            "dt": 1693537200,
            "main": {
              "temp": 285.01,
              "feels_like": 284.5,
              "temp_min": 285.01,
              "temp_max": 285.01,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 932,
              "humidity": 86,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02n"
              }
            ],
            "clouds": {"all": 17},
            "wind": {"speed": 2.24, "deg": 207, "gust": 2.29},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-01 03:00:00"
          },
          {
            "dt": 1693548000,
            "main": {
              "temp": 287.34,
              "feels_like": 286.9,
              "temp_min": 287.34,
              "temp_max": 287.34,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 933,
              "humidity": 80,
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
            "clouds": {"all": 11},
            "wind": {"speed": 1.64, "deg": 202, "gust": 2.36},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-01 06:00:00"
          },
          {
            "dt": 1693558800,
            "main": {
              "temp": 294.02,
              "feels_like": 293.44,
              "temp_min": 294.02,
              "temp_max": 294.02,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 935,
              "humidity": 49,
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
            "wind": {"speed": 0.84, "deg": 91, "gust": 1.63},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-01 09:00:00"
          },
          {
            "dt": 1693569600,
            "main": {
              "temp": 294.78,
              "feels_like": 294.38,
              "temp_min": 294.78,
              "temp_max": 294.78,
              "pressure": 1017,
              "sea_level": 1017,
              "grnd_level": 934,
              "humidity": 53,
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
            "clouds": {"all": 27},
            "wind": {"speed": 0.95, "deg": 144, "gust": 2.79},
            "visibility": 10000,
            "pop": 0.28,
            "rain": {"3h": 0.13},
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-01 12:00:00"
          },
          {
            "dt": 1693580400,
            "main": {
              "temp": 295.09,
              "feels_like": 294.7,
              "temp_min": 295.09,
              "temp_max": 295.09,
              "pressure": 1017,
              "sea_level": 1017,
              "grnd_level": 934,
              "humidity": 52,
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
            "clouds": {"all": 92},
            "wind": {"speed": 0.36, "deg": 171, "gust": 1.43},
            "visibility": 10000,
            "pop": 0.32,
            "rain": {"3h": 0.17},
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-01 15:00:00"
          },
          {
            "dt": 1693591200,
            "main": {
              "temp": 290.84,
              "feels_like": 290.52,
              "temp_min": 290.84,
              "temp_max": 290.84,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 934,
              "humidity": 71,
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
            "clouds": {"all": 96},
            "wind": {"speed": 1.08, "deg": 221, "gust": 1.96},
            "visibility": 10000,
            "pop": 0.28,
            "rain": {"3h": 0.17},
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-01 18:00:00"
          },
          {
            "dt": 1693602000,
            "main": {
              "temp": 288.52,
              "feels_like": 288.2,
              "temp_min": 288.52,
              "temp_max": 288.52,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 934,
              "humidity": 80,
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
            "clouds": {"all": 90},
            "wind": {"speed": 2.2, "deg": 224, "gust": 2.24},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-01 21:00:00"
          },
          {
            "dt": 1693612800,
            "main": {
              "temp": 287.35,
              "feels_like": 286.84,
              "temp_min": 287.35,
              "temp_max": 287.35,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 934,
              "humidity": 77,
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
            "clouds": {"all": 95},
            "wind": {"speed": 2.18, "deg": 231, "gust": 2.16},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-02 00:00:00"
          },
          {
            "dt": 1693623600,
            "main": {
              "temp": 286.88,
              "feels_like": 286.29,
              "temp_min": 286.88,
              "temp_max": 286.88,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 933,
              "humidity": 76,
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
            "wind": {"speed": 1.78, "deg": 230, "gust": 1.69},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-02 03:00:00"
          },
          {
            "dt": 1693634400,
            "main": {
              "temp": 288.67,
              "feels_like": 288.16,
              "temp_min": 288.67,
              "temp_max": 288.67,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 934,
              "humidity": 72,
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
            "clouds": {"all": 99},
            "wind": {"speed": 1.19, "deg": 249, "gust": 1.37},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-02 06:00:00"
          },
          {
            "dt": 1693645200,
            "main": {
              "temp": 295.24,
              "feels_like": 294.81,
              "temp_min": 295.24,
              "temp_max": 295.24,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 936,
              "humidity": 50,
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
            "clouds": {"all": 43},
            "wind": {"speed": 1.19, "deg": 24, "gust": 1.29},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-02 09:00:00"
          },
          {
            "dt": 1693656000,
            "main": {
              "temp": 298.75,
              "feels_like": 298.33,
              "temp_min": 298.75,
              "temp_max": 298.75,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 936,
              "humidity": 37,
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
            "clouds": {"all": 43},
            "wind": {"speed": 1.73, "deg": 37, "gust": 2.6},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-02 12:00:00"
          },
          {
            "dt": 1693666800,
            "main": {
              "temp": 298.03,
              "feels_like": 297.59,
              "temp_min": 298.03,
              "temp_max": 298.03,
              "pressure": 1017,
              "sea_level": 1017,
              "grnd_level": 935,
              "humidity": 39,
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
            "clouds": {"all": 71},
            "wind": {"speed": 1.92, "deg": 16, "gust": 2.08},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-02 15:00:00"
          },
          {
            "dt": 1693677600,
            "main": {
              "temp": 292,
              "feels_like": 291.64,
              "temp_min": 292,
              "temp_max": 292,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 935,
              "humidity": 65,
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
            "clouds": {"all": 77},
            "wind": {"speed": 1.92, "deg": 85, "gust": 4.3},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-02 18:00:00"
          },
          {
            "dt": 1693688400,
            "main": {
              "temp": 288.92,
              "feels_like": 288.59,
              "temp_min": 288.92,
              "temp_max": 288.92,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 935,
              "humidity": 78,
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
            "wind": {"speed": 1.26, "deg": 225, "gust": 1.3},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-02 21:00:00"
          },
          {
            "dt": 1693699200,
            "main": {
              "temp": 288.6,
              "feels_like": 288.24,
              "temp_min": 288.6,
              "temp_max": 288.6,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 935,
              "humidity": 78,
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
            "clouds": {"all": 74},
            "wind": {"speed": 1.57, "deg": 246, "gust": 1.52},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-03 00:00:00"
          },
          {
            "dt": 1693710000,
            "main": {
              "temp": 288,
              "feels_like": 287.66,
              "temp_min": 288,
              "temp_max": 288,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 935,
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
            "clouds": {"all": 96},
            "wind": {"speed": 1.12, "deg": 260, "gust": 1.09},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-03 03:00:00"
          },
          {
            "dt": 1693720800,
            "main": {
              "temp": 290.2,
              "feels_like": 289.87,
              "temp_min": 290.2,
              "temp_max": 290.2,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 935,
              "humidity": 73,
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
            "clouds": {"all": 98},
            "wind": {"speed": 0.74, "deg": 239, "gust": 0.81},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-03 06:00:00"
          },
          {
            "dt": 1693731600,
            "main": {
              "temp": 294.3,
              "feels_like": 293.96,
              "temp_min": 294.3,
              "temp_max": 294.3,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 936,
              "humidity": 57,
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
            "wind": {"speed": 1.1, "deg": 34, "gust": 0.7},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-03 09:00:00"
          },
          {
            "dt": 1693742400,
            "main": {
              "temp": 295.09,
              "feels_like": 294.8,
              "temp_min": 295.09,
              "temp_max": 295.09,
              "pressure": 1019,
              "sea_level": 1019,
              "grnd_level": 936,
              "humidity": 56,
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
            "wind": {"speed": 0.85, "deg": 353, "gust": 1.04},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-03 12:00:00"
          },
          {
            "dt": 1693753200,
            "main": {
              "temp": 298.07,
              "feels_like": 297.66,
              "temp_min": 298.07,
              "temp_max": 298.07,
              "pressure": 1016,
              "sea_level": 1016,
              "grnd_level": 934,
              "humidity": 40,
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
            "clouds": {"all": 98},
            "wind": {"speed": 0.47, "deg": 189, "gust": 2.67},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2023-09-03 15:00:00"
          },
          {
            "dt": 1693764000,
            "main": {
              "temp": 291.66,
              "feels_like": 291.16,
              "temp_min": 291.66,
              "temp_max": 291.66,
              "pressure": 1016,
              "sea_level": 1016,
              "grnd_level": 932,
              "humidity": 61,
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
            "clouds": {"all": 92},
            "wind": {"speed": 1.12, "deg": 192, "gust": 1.31},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-03 18:00:00"
          },
          {
            "dt": 1693774800,
            "main": {
              "temp": 290.35,
              "feels_like": 289.77,
              "temp_min": 290.35,
              "temp_max": 290.35,
              "pressure": 1016,
              "sea_level": 1016,
              "grnd_level": 932,
              "humidity": 63,
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
            "clouds": {"all": 95},
            "wind": {"speed": 2.31, "deg": 229, "gust": 2.32},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2023-09-03 21:00:00"
          }
        ],
        "city": {
          "id": 3163858,
          "name": "Zocca",
          "coord": {"lat": 44.34, "lon": 10.99},
          "country": "IT",
          "population": 4593,
          "timezone": 7200,
          "sunrise": 1693370169,
          "sunset": 1693418275
        }
      };
      // await fetchForecastData(
      //     _locationData.latitude!, _locationData.longitude!);

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

          print("forecastData: " + forecastData.toString());
        }
      }

      setState(() {
        forecastData = forecastData;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherImage(String mainWeather) {
    switch (mainWeather.toLowerCase()) {
      case 'clear':
        return 'assets/page-1/images/sea_sunny.png';
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return 'assets/page-1/images/sea_rainy.png';
      case 'clouds':
        return 'assets/page-1/images/sea_cloudy.png';
      default:
        return 'assets/page-1/images/sea_sunny.png';
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
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            _loadWeather();
          },
          child: const Icon(Icons.refresh),
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
                    //background image
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 430 * fem,
                          height: 382.22 * fem,
                          child: Image.asset(
                            getWeatherImage(
                                currentWeather?['weather'][0]['main']),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  //Today's weather
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
                  //Data Table
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
                            //today's forecast
                            Container(
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(
                                  39 * fem, 0 * fem, 41 * fem, 5 * fem),
                              width: double.infinity,
                              height: 80 * fem,
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
                            //Divider line
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 33 * fem),
                              width: double.infinity,
                              height: 3 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                            ),
                            //5day forecast data table
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
