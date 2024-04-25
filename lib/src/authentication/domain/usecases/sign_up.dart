import 'package:education_app/core/useCases/use_cases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SigUp extends UseCaseWithParams<void, SignInParams> {
  const SigUp(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(SignInParams params) =>
      _authenticationRepository.signUp(
        email: params.email,
        fullName: params.fullName,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
    required this.fullName,
  });
  const SignInParams.empty()
      : email = '',
        password = '',
        fullName = '';

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password];
}
