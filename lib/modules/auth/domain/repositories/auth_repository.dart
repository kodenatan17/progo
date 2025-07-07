import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:progo/core/network/api_client.dart';
import 'package:progo/core/network/models/auth_models.dart';
import 'package:progo/core/network/interceptors/auth_interceptor.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResponse>> login(LoginRequest request);
  Future<Either<String, RegisterResponse>> register(RegisterRequest request);
  Future<void> logout();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  
  AuthRepositoryImpl(this._apiClient);
  
  @override
  Future<Either<String, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiClient.login(request);
      // Save token on successful login
      await AuthInterceptor.saveToken(response.data.token);
      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, RegisterResponse>> register(RegisterRequest request) async {
    try {
      final response = await _apiClient.register(request);
      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<void> logout() async {
    await AuthInterceptor.clearToken();
  }
} 