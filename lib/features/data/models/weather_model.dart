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
    final location = json['location'] ?? {};
    final current = (json['current'] is Map<String, dynamic>)
        ? json['current'] as Map<String, dynamic>
        : <String, dynamic>{};
    final condition = (current['condition'] is Map<String, dynamic>)
        ? current['condition'] as Map<String, dynamic>
        : <String, dynamic>{};

    double _toDouble(dynamic value, [double defaultValue = 0.0]) {
      if (value == null) return defaultValue;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? defaultValue;
      }
      return defaultValue;
    }

    double _lat = 0.0;
    double _lon = 0.0;
    try {
      _lat = _toDouble(location['lat']);
    } catch (_) {}
    try {
      _lon = _toDouble(location['lon']);
    } catch (_) {}

    return WeatherModel(
      cityName: location['name']?.toString() ?? '',
      region: location['region']?.toString() ?? '',
      country: location['country']?.toString() ?? '',
      temperature: _toDouble(current['temp_c']),
      feelsLike: _toDouble(current['feelslike_c']),
      condition: condition['text']?.toString() ?? 'N/A',
      conditionIcon: condition['icon']?.toString() ?? '',
      humidity: _toDouble(current['humidity']),
      windSpeed: _toDouble(current['wind_kph']),
      windDirection: current['wind_dir']?.toString() ?? '',
      latitude: _lat,
      longitude: _lon,
      localTime: location['localtime']?.toString() ?? '',
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
