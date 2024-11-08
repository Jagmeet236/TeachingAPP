import 'package:education_app/core/useCases/use_cases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';

class ForgotPasswordUseCase extends UseCaseWithParams<void, String> {
  const ForgotPasswordUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(String params) =>
      _authenticationRepository.forgotPassword(params);
}
