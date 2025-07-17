import 'package:geolocator/geolocator.dart';
import 'package:climater/features/data/models/location_model.dart';
import 'package:climater/features/data/datasources/location_remote_data_source.dart';
import 'package:climater/core/error/exceptions.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationException(
          message: 'Location services are disabled',
        );
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const LocationException(
            message: 'Location permissions are denied',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const LocationException(
          message: 'Location permissions are permanently denied',
        );
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      if (e is LocationException) {
        rethrow;
      } else {
        throw LocationException(
          message: 'Failed to get location: ${e.toString()}',
        );
      }
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      throw LocationException(
        message: 'Failed to check location service: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      throw LocationException(
        message: 'Failed to request permission: ${e.toString()}',
      );
    }
  }
}
