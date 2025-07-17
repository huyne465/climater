class LocationEntity {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationEntity &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'LocationEntity(latitude: $latitude, longitude: $longitude, address: $address)';
  }
}
