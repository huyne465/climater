import 'package:climater/features/data/models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getCurrentLocation();
  Future<bool> isLocationServiceEnabled();
  Future<bool> requestLocationPermission();
}
