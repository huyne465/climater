import 'package:climater/features/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required String cityName,
    required String region,
    required String country,
    required double temperature,
    required double feelsLike,
    required String condition,
    required String conditionIcon,
    required double humidity,
    required double windSpeed,
    required String windDirection,
    required double latitude,
    required double longitude,
    required String localTime,
  }) : super(
         cityName: cityName,
         region: region,
         country: country,
         temperature: temperature,
         feelsLike: feelsLike,
         condition: condition,
         conditionIcon: conditionIcon,
         humidity: humidity,
         windSpeed: windSpeed,
         windDirection: windDirection,
         latitude: latitude,
         longitude: longitude,
         localTime: localTime,
       );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final current = json['current'];

    return WeatherModel(
      cityName: location['name'] ?? '',
      region: location['region'] ?? '',
      country: location['country'] ?? '',
      temperature: (current['temp_c'] as num).toDouble(),
      feelsLike: (current['feelslike_c'] as num).toDouble(),
      condition: current['condition']['text'] ?? '',
      conditionIcon: current['condition']['icon'] ?? '',
      humidity: (current['humidity'] as num).toDouble(),
      windSpeed: (current['wind_kph'] as num).toDouble(),
      windDirection: current['wind_dir'] ?? '',
      latitude: (location['lat'] as num).toDouble(),
      longitude: (location['lon'] as num).toDouble(),
      localTime: location['localtime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'name': cityName,
        'region': region,
        'country': country,
        'lat': latitude,
        'lon': longitude,
        'localtime': localTime,
      },
      'current': {
        'temp_c': temperature,
        'feelslike_c': feelsLike,
        'condition': {'text': condition, 'icon': conditionIcon},
        'humidity': humidity,
        'wind_kph': windSpeed,
        'wind_dir': windDirection,
      },
    };
  }

  WeatherModel copyWith({
    String? cityName,
    String? region,
    String? country,
    double? temperature,
    double? feelsLike,
    String? condition,
    String? conditionIcon,
    double? humidity,
    double? windSpeed,
    String? windDirection,
    double? latitude,
    double? longitude,
    String? localTime,
  }) {
    return WeatherModel(
      cityName: cityName ?? this.cityName,
      region: region ?? this.region,
      country: country ?? this.country,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      condition: condition ?? this.condition,
      conditionIcon: conditionIcon ?? this.conditionIcon,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      localTime: localTime ?? this.localTime,
    );
  }
}
