import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:progo/core/network/models/auth_models.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  
  // Auth endpoints
  @POST('/auth/login')
  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest request);
  
  @POST('/auth/register')
  Future<HttpResponse<RegisterResponse>> register(@Body() RegisterRequest request);
  
  // Add more endpoints as needed
} 