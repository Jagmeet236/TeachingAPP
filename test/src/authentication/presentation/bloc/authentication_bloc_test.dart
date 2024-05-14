import 'package:education_app/src/authentication/domain/useCases/forgot_password.dart';
import 'package:education_app/src/authentication/domain/useCases/sign_in.dart';
import 'package:education_app/src/authentication/domain/useCases/sign_up.dart';
import 'package:education_app/src/authentication/domain/useCases/update_user.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignInUseCase {}

class MockSignUp extends Mock implements SignUpUseCase {}

class MockForgotPassword extends Mock implements ForgotPasswordUseCase {}

class MockUpdateUser extends Mock implements UpdateUserUseCase {}

void main() {
  late SignInUseCase signIn;
  late SignUpUseCase signUp;
  late UpdateUserUseCase updateUser;
  late ForgotPasswordUseCase forgotPassword;
  late AuthenticationBloc authenticationBloc;
  setUp(() async {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authenticationBloc = AuthenticationBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });
  tearDown(() => authenticationBloc.close());
}
