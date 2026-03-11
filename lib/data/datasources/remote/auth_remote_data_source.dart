// lib/data/datasources/remote/auth_remote_data_source.dart

import '../../../core/errors/exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';


abstract class AuthRemoteDataSource {
  Future<String> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String> login({required String email, required String password}) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.login,
        {
          "email": email,
          "password": password,
        },
      );

      // Assuming API returns { "token": "abcd1234" }
      final token = response['token'];
      if (token == null) {
        throw ServerException(message: "Login failed");
      }
      return token;
    } on Exception catch (e) {
      throw e; // Repository will handle exceptions
    }
  }
}