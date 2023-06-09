part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class NotAuthenticatedAuthState extends AuthState {}

class AuthenticatedAuthState extends AuthState {
  final AppUser user;

  const AuthenticatedAuthState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthedErrorAuthState extends AuthenticatedAuthState {
  final String message;

  const AuthedErrorAuthState({
    required this.message,
    required super.user,
  });

  @override
  List<Object> get props => [message];
}
