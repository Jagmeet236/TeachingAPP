import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/useCases/forgot_password.dart';
import 'package:education_app/src/authentication/domain/useCases/sign_in.dart';
import 'package:education_app/src/authentication/domain/useCases/sign_up.dart';

import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
  }
  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;
}
