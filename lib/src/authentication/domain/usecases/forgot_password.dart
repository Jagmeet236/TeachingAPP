import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(String params) =>
      _authenticationRepository.forgotPassword(params);
}
