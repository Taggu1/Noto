part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogInAuthEvent extends AuthEvent {
  final String password;
  final String email;

  const LogInAuthEvent({
    required this.password,
    required this.email,
  });

  @override
  List<Object> get props => [password, email];
}

class FetchUserAuthEvent extends AuthEvent {}

class SignOutAuthEvent extends AuthEvent {}

class EditUserDataEvent extends AuthEvent {
  final AppUser user;
  final AppUser oldUser;

  const EditUserDataEvent(this.user, this.oldUser);

  @override
  List<Object> get props => [user, oldUser];
}
