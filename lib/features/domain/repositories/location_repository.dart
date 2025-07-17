import 'package:climater/core/error/failures.dart';
import 'package:climater/features/domain/entities/location_entity.dart';

abstract class LocationRepository {
  ResultFuture<LocationEntity> getCurrentLocation();
  ResultFuture<bool> isLocationServiceEnabled();
  ResultFuture<bool> requestLocationPermission();
}
