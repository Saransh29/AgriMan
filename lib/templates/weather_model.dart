class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double? temperature;

  TemperatureInfo({this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

// class HumidityInfo {
//   final double? humidity;

//   HumidityInfo({this.humidity});

//   factory HumidityInfo.fromJson(Map<String, dynamic> json) {
//     final humidity = json['humidity'];
//     return HumidityInfo(humidity: humidity);
//   }
// }

// class WindInfo {
//   final double? windSpeed;
//   final double? windDeg;

//   WindInfo({this.windSpeed, this.windDeg});

//   factory WindInfo.fromJson(Map<String, dynamic> json) {
//     final windSpeed = json['speed'];
//     final windDeg = json['deg'];
//     return WindInfo(windSpeed: windSpeed, windDeg: windDeg);
//   }
// }

class WeatherResponse {
  final String? cityName;
  final TemperatureInfo? tempInfo;
  final WeatherInfo? weatherInfo;
  // final HumidityInfo? humidityInfo;
  // final WindInfo? windInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo!.icon}@2x.png';
  }

  WeatherResponse(
      {this.cityName,
      this.tempInfo,
      this.weatherInfo,
      // this.humidityInfo,
      // this.windInfo
      });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    // final humidityInfoJson = json['main'];
    // final humidityInfo = HumidityInfo.fromJson(humidityInfoJson);

    // final windInfoJson = json['wind'];
    // final windInfo = WindInfo.fromJson(windInfoJson);

    return WeatherResponse(
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      // humidityInfo: humidityInfo,
      // windInfo: windInfo,
    );
  }
}
