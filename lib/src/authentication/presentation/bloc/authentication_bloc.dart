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
    on<AuthenticationEvent>((event, emit) {});
  }
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final ForgotPasswordUseCase _forgotPassword;
  final UpdateUserUseCase _updateUser;
}
