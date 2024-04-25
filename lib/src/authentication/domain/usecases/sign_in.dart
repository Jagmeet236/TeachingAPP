import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SigIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SigIn(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _authenticationRepository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });
  const SignInParams.empty()
      : email = '',
        password = '';
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
