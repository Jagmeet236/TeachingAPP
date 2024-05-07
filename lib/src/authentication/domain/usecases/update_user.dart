import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/useCases/use_cases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUserUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(UpdateUserParams params) =>
      _authenticationRepository.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });
  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.displayName,
          userData: '',
        );
  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
