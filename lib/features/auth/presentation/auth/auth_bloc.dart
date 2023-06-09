import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(NotAuthenticatedAuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInAuthEvent) {
        emit(LoadingAuthState());

        final userOrFailure = await repository.signUp(
          email: event.email,
          password: event.password,
        );

        emit(
          _mapUserOrFailureToAuthState(userOrFailure),
        );
      } else if (event is LogInAuthEvent) {
        emit(LoadingAuthState());

        final userOrFailure = await repository.logIn(
          email: event.email,
          password: event.password,
        );

        emit(
          _mapUserOrFailureToAuthState(userOrFailure),
        );
      } else if (event is FetchUserAuthEvent) {
        print("ASDAD");
        emit(LoadingAuthState());

        final userOrFailure = await repository.fetchUser();

        emit(
          _mapUserOrFailureToAuthState(userOrFailure),
        );
      } else if (event is SignOutAuthEvent) {
        emit(LoadingAuthState());

        final unitOrFailure = await repository.signOut();

        emit(
          _mapUnitOrFailureToAuthState(unitOrFailure),
        );
      }
    });
  }

  AuthState _mapUserOrFailureToAuthState(
      Either<Failure, AppUser?> userOrFailure) {
    return userOrFailure.fold(
      (failure) => ErrorAuthState(
        message: failure.message,
      ),
      (user) {
        print(user);
        return user == null
            ? NotAuthenticatedAuthState()
            : AuthenticatedAuthState(
                user: user,
              );
      },
    );
  }

  AuthState _mapUnitOrFailureToAuthState(Either<Failure, Unit> userOrFailure,
      {AppUser? eventUser, AppUser? oldUser}) {
    return userOrFailure.fold(
      (failure) {
        print(oldUser);
        return oldUser == null
            ? state
            : AuthedErrorAuthState(message: failure.message, user: oldUser);
      },
      (_) {
        return eventUser == null
            ? NotAuthenticatedAuthState()
            : AuthenticatedAuthState(
                user: eventUser,
              );
      },
    );
  }
}
