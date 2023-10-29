// class Weather {
//   final int id;
//   final String name;
//   final double temp;
//   final int humidity;
//   final double windSpeed;

//   Weather(this.id, this.name, this.temp, this.humidity, this.windSpeed);

//   factory Weather.fromJson(Map<String, dynamic> parsedJson) {
//     final id = parsedJson['id'] as int;
//     final name = parsedJson['title'] as String;
//     final temp = parsedJson['main']['temp'] as double;
//     final humidity = parsedJson['main']['humidity'] as int;
//     final windSpeed = parsedJson['wind']['speed'] as double;

//     return Weather(id, name, temp, humidity, windSpeed);
//   }
// }


class Weather {
  final String name;
  Main main;
  Wind wind;

  Weather(this.name, this.main, this.wind);

  factory Weather.fromJson(Map<String, dynamic> parsedJson) {
    final name = parsedJson['name'] as String;
    final main = Main.fromJson(parsedJson["main"]);
    final wind = Wind.fromJson(parsedJson["wind"]);

    return Weather(name, main, wind);
  }
}

class Main {
  final double temp;
  final int humidity;

  Main(this.temp, this.humidity);

  factory Main.fromJson(Map<String, dynamic> parsedJson) {
    final temp = (parsedJson['temp'] - 273) as double;
    final humidity = parsedJson['humidity'] as int;

    return Main(temp, humidity);
  }
}

class Wind {
  final double speed;

  Wind(this.speed);

  factory Wind.fromJson(Map<String, dynamic> parsedJson) {
    final speed = parsedJson['speed'] as double;

    return Wind(speed);
  }
}