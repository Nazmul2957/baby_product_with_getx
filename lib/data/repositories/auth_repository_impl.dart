// lib/data/repositories/auth_repository_impl.dart

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../../core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final token = await remoteDataSource.login(email: email, password: password);

      // Save token locally
      await localDataSource.saveToken(token);

      // Optionally, return User entity
      return User(id: 0, name: email.split('@')[0], email: email, token: token);
    } catch (e) {
      throw ServerFailure( e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearToken();
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }
}