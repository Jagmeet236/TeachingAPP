import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
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
  const tSignUpParams = SignUpParams.empty();
  const tSignInParams = SignInParams.empty();
  const tUpdateUSerParams = UpdateUserParams.empty();

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
  setUpAll(() {
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tUpdateUSerParams);
  });
  test('initialState should be [AuthenticationInitial]', () {
    expect(authenticationBloc.state, AuthenticationInitial());
  });
  final tServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted',
  );

  group('signInEvent', () {
    const tUser = LocalUserModel.empty();
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, SignedIn] when '
      '[signInEvent] is added',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] '
      'when signIn fails',
      build: () {
        when(() => signIn(any())).thenAnswer(
          (_) async => left(tServerFailure),
        );
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });
  group('signUpEvent', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, SignedUp] '
      'when SignUpEvent is added and signUp succeeds',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        const SignedUp(),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] '
      'when signUp fails',
      build: () {
        when(() => signUp(any())).thenAnswer(
          (_) async => left(tServerFailure),
        );
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
          fullName: tSignUpParams.email,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });
}
