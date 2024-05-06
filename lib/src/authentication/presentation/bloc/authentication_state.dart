part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class SignedIn extends AuthenticationState {
  const SignedIn(this.user);
  final LocalUser user;
  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthenticationState {
  const SignedUp();
}

class ForgotPasswordSent extends AuthenticationState {
  const ForgotPasswordSent();
}

class UserUpdated extends AuthenticationState {
  const UserUpdated();
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);
  final String message;
}
