import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:progo/modules/auth/domain/usecases/login_usecase.dart';
import 'package:progo/modules/auth/domain/usecases/register_usecase.dart';
import 'package:progo/core/network/models/auth_models.dart';

// Events
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  
  RegisterRequested({required this.email, required this.password, required this.name});
}

class LogoutRequested extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  
  AuthSuccess({required this.message});
}

class AuthFailure extends AuthState {
  final String error;
  
  AuthFailure({required this.error});
}

// Bloc
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  
  AuthBloc(this._loginUseCase, this._registerUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }
  
  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final request = LoginRequest(email: event.email, password: event.password);
    final result = await _loginUseCase(request);
    
    result.fold(
      (error) => emit(AuthFailure(error: error)),
      (response) => emit(AuthSuccess(message: 'Login successful'))
    );
  }
  
  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final request = RegisterRequest(
      email: event.email, 
      password: event.password, 
      name: event.name
    );
    final result = await _registerUseCase(request);
    
    result.fold(
      (error) => emit(AuthFailure(error: error)),
      (response) => emit(AuthSuccess(message: response.message))
    );
  }
  
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Implement logout logic
    emit(AuthSuccess(message: 'Logged out successfully'));
  }
} 