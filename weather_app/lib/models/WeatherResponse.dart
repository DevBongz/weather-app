class WeatherResponse {
  Coord? coord;
  Weather? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherResponse({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  //convert json response into dart weatherResponse object
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        coord: Coord.fromJson(json["coord"]),
      );
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) =>
      Coord(lon: json["lon"].toDouble(), lat: json["lat"].toDouble());
}

class Sys {}

class Clouds {}

class Wind {}

class Main {}

class Weather {}
