import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/app_user.dart';

abstract class AuthRemoteDataSource {
  Future<AppUser> signUp({required String password, required String email});
  Future<AppUser> logIn({required String password, required String email});
  Future<Unit> signOut();
  Future<AppUser?> fetchUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore database;

  AuthRemoteDataSourceImpl({
    required this.auth,
    required this.database,
  });

  @override
  Future<AppUser> logIn(
      {required String password, required String email}) async {
    final user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUser(
      email: email,
      id: user.user!.uid,
    );
  }

  @override
  Future<Unit> signOut() async {
    auth.signOut();
    return unit;
  }

  @override
  Future<AppUser> signUp(
      {required String password, required String email}) async {
    final user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUser(
      email: email,
      id: user.user!.uid,
    );
  }

  @override
  Future<AppUser?> fetchUser() async {
    if (auth.currentUser == null) {
      return null;
    }
    final user = auth.currentUser;
    return AppUser(
      email: user!.email,
      id: user.uid,
    );
  }
}
