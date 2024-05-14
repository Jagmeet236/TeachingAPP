import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/useCases/authentication_use_cases.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required ForgotPasswordUseCase forgotPassword,
    required UpdateUserUseCase updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      emit(const AuthenticationLoading());
    });

    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
  }
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final ForgotPasswordUseCase _forgotPassword;
  final UpdateUserUseCase _updateUser;
  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const SignedUp()),
    );
  }
}
