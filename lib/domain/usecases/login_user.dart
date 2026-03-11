// lib/domain/usecases/login_user.dart

import '../repositories/auth_repository.dart';
import '../entities/user.dart';
import '../../core/errors/failures.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  /// Login using email & password
  /// Returns a [User] entity with token
  Future<User> call({required String email, required String password}) async {
    try {
      final user = await repository.login(email: email, password: password);
      return user;
    } on Failure catch (f) {
      throw f;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}