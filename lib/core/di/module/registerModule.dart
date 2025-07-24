import 'package:climater/features/data/services/Dio/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @injectable
  Dio provideDio(DioService dioService) => dioService.dio;
}
