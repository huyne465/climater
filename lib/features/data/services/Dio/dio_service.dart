import 'package:climater/core/error/errorHandler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(_createBaseOptions());
    _setupInterceptors();
  }

  Dio get dio => _dio;

  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: 'http://api.weatherapi.com/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },
    );
  }

  void _setupInterceptors() {
    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('🚀 REQUEST[${options.method}] => ${options.uri}');
            print('📤 Headers: ${options.headers}');
            print('📤 Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print(
              '✅ RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
            );
            print('📥 Data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            print(
              '❌ ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri}',
            );
            print('❌ Message: ${error.message}');
            print('❌ Response: ${error.response?.data}');
          }
          handler.next(error);
        },
      ),
    );

    // API Key Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add API key to all requests
          options.queryParameters['key'] = '0dc8b445aeb544a99d972515252207';
          options.queryParameters['aqi'] = 'no';
          handler.next(options);
        },
      ),
    );

    // Error Handling Interceptor
    _dio.interceptors.add(ErrorInterceptor());
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Unknown error occurred';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage =
            'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = handleHttpError(err.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage =
            'Connection error. Please check your internet connection.';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Certificate verification failed';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Unknown error: ${err.message}';
        break;
    }

    // Create custom DioException with user-friendly message
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: errorMessage,
    );

    handler.next(customError);
  }
}
