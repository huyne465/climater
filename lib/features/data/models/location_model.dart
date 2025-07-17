import 'package:climater/features/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required double latitude,
    required double longitude,
    String? address,
  }) : super(latitude: latitude, longitude: longitude, address: address);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'address': address};
  }

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}
