import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:progo/modules/auth/domain/repositories/auth_repository.dart';
import 'package:progo/core/network/models/auth_models.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _authRepository;
  
  RegisterUseCase(this._authRepository);
  
  Future<Either<String, RegisterResponse>> call(RegisterRequest request) async {
    return await _authRepository.register(request);
  }
} 