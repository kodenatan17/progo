import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:progo/core/network/api_client.dart';
import 'package:progo/core/network/interceptors/auth_interceptor.dart';
import 'package:progo/core/network/interceptors/logging_interceptor.dart';

@module
abstract class NetworkModule {
  
  @singleton
  Dio get dio {
    final dio = Dio();
    
    // Add interceptors
    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(),
    ]);
    
    return dio;
  }
  
  @singleton
  ApiClient get apiClient => ApiClient(dio);
} 