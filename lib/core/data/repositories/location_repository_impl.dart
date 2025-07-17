import 'package:dartz/dartz.dart';
import 'package:climater/features/domain/entities/location_entity.dart';
import 'package:climater/features/domain/repositories/location_repository.dart';
import 'package:climater/features/data/datasources/location_remote_data_source.dart';
import 'package:climater/core/error/failures.dart';
import 'package:climater/core/error/exceptions.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<LocationEntity> getCurrentLocation() async {
    try {
      final result = await remoteDataSource.getCurrentLocation();
      return Right(result);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    } catch (e) {
      return Left(
        LocationFailure(message: 'Unexpected error: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<bool> isLocationServiceEnabled() async {
    try {
      final result = await remoteDataSource.isLocationServiceEnabled();
      return Right(result);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    } catch (e) {
      return Left(
        LocationFailure(message: 'Unexpected error: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<bool> requestLocationPermission() async {
    try {
      final result = await remoteDataSource.requestLocationPermission();
      return Right(result);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    } catch (e) {
      return Left(
        LocationFailure(message: 'Unexpected error: ${e.toString()}'),
      );
    }
  }
}
