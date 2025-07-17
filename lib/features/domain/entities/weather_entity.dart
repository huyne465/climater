class WeatherEntity {
  final String cityName;
  final String region;
  final String country;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String conditionIcon;
  final double humidity;
  final double windSpeed;
  final String windDirection;
  final double latitude;
  final double longitude;
  final String localTime;

  const WeatherEntity({
    required this.cityName,
    required this.region,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.conditionIcon,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.latitude,
    required this.longitude,
    required this.localTime,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherEntity &&
        other.cityName == cityName &&
        other.temperature == temperature &&
        other.condition == condition;
  }

  @override
  int get hashCode =>
      cityName.hashCode ^ temperature.hashCode ^ condition.hashCode;

  @override
  String toString() {
    return 'WeatherEntity(cityName: $cityName, temperature: $temperature°C, condition: $condition)';
  }
}
