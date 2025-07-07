import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:progo/modules/auth/domain/repositories/auth_repository.dart';
import 'package:progo/core/network/models/auth_models.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;
  
  LoginUseCase(this._authRepository);
  
  Future<Either<String, LoginResponse>> call(LoginRequest request) async {
    return await _authRepository.login(request);
  }
} 