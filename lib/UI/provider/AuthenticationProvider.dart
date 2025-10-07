import 'package:evently/database/UsersDao.dart';
import 'package:evently/database/model/AppUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  var _fb_authService = FirebaseAuth.instance; //singleton

  Future<AuthResponse> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _fb_authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
          id: credential.user?.uid,
          name: name,
          email: email
      );

      await UsersDao.addUser(user);

      return AuthResponse(success: true, credential: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.weakPass.code) {
        return AuthResponse(success: false, failure: AuthFailure.weakPass);
      } else if (e.code == AuthFailure.emailInUse.code) {
        return AuthResponse(success: false, failure: AuthFailure.emailInUse);
      } else {
        return AuthResponse(success: false, failure: AuthFailure.generalError);
      }
    } catch (e) {
      return AuthResponse(success: false, failure: AuthFailure.generalError);
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final credential = await _fb_authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // retrieve user
      AppUser? user = await UsersDao.getUserById(credential.user?.uid);

      return AuthResponse(success: true, credential: credential, user: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.invalidCredential.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.invalidCredential,
        );
      }
    } catch (e) {
      return AuthResponse(success: false, failure: AuthFailure.generalError);
    }
    return AuthResponse(success: false, failure: AuthFailure.generalError);
  }
}

class AuthResponse {
  bool success;

  AuthFailure? failure;

  UserCredential? credential;

  AppUser? user;

  AuthResponse({required this.success, this.failure,
    this.credential, this.user});
}

enum AuthFailure {
  weakPass('weak-password'),
  emailInUse('email-already-in-use'),
  invalidCredential("invalid credential"),
  generalError('something went wrong');

  final String code;

  const AuthFailure(this.code);
}
