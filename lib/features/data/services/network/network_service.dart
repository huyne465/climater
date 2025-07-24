import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';

@injectable
class NetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data!;
    } on DioException catch (e) {
      throw HandleDioException(e);
    }
  }

  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data!;
    } on DioException catch (e) {
      throw HandleDioException(e);
    }
  }

  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data!;
    } on DioException catch (e) {
      throw HandleDioException(e);
    }
  }

  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data!;
    } on DioException catch (e) {
      throw HandleDioException(e);
    }
  }
}
