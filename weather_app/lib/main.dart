import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  // Map<String, dynamic>? currentWeather;

  Map<String, dynamic> currentWeather = {
    "coord": {
        "lon": 18.49,
        "lat": 33.81
    },
    "weather": [
        {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 300.6,
        "feels_like": 303.8,
        "temp_min": 300.6,
        "temp_max": 300.6,
        "pressure": 1013,
        "humidity": 79,
        "sea_level": 1013,
        "grnd_level": 1013
    },
    "visibility": 10000,
    "wind": {
        "speed": 3.16,
        "deg": 314,
        "gust": 3.84
    },
    "clouds": {
        "all": 0
    },
    "dt": 1693069237,
    "sys": {
        "sunrise": 1693023329,
        "sunset": 1693070456
    },
    "timezone": 3600,
    "id": 0,
    "name": "",
    "cod": 200
};

  Map<String, dynamic>? forecast;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: [
          if(currentWeather != null)
            Text('Temperature: ${currentWeather!['main']['temp']}°C')
        ],
      ),
    );
  }
}


