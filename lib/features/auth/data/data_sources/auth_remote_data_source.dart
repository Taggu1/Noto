import 'package:dartz/dartz.dart';
import 'package:firedart/firedart.dart';

import '../../domain/models/app_user.dart';

abstract class AuthRemoteDataSource {
  Future<AppUser> signUp({required String password, required String email});
  Future<AppUser> logIn({required String password, required String email});
  Future<Unit> signOut();
  Future<AppUser?> fetchUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth auth;
  final Firestore database;

  AuthRemoteDataSourceImpl({
    required this.auth,
    required this.database,
  });

  @override
  Future<AppUser> logIn(
      {required String password, required String email}) async {
    // TODO: implement logIn
    final user = await auth.signIn(
      email,
      password,
    );

    return AppUser(email: user.email, id: user.id);
  }

  @override
  Future<Unit> signOut() async {
    auth.signOut();
    return unit;
  }

  @override
  Future<AppUser> signUp(
      {required String password, required String email}) async {
    final user = await auth.signUp(
      email,
      password,
    );

    return AppUser(
      email: user.email,
      id: user.id,
    );
  }

  @override
  Future<AppUser?> fetchUser() async {
    if (!auth.isSignedIn) {
      print("nice");

      return null;
    }
    final user = await auth.getUser();
    print(user);
    return AppUser(
      email: user.email,
      id: user.id,
    );
  }
}
