// lib/presentation/bindings/auth_binding.dart
import 'package:get/get.dart';
import '../../domain/usecases/login_user.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/datasources/local/auth_local_data_source.dart';
import '../../core/network/api_client.dart';
import '../../presentation/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthBinding extends Bindings {
  @override
  void dependencies() async {
    final prefs = await SharedPreferences.getInstance();

    final apiClient = ApiClient(client: http.Client());

    final remoteDataSource = AuthRemoteDataSourceImpl(apiClient: apiClient);
    final localDataSource = AuthLocalDataSourceImpl(prefs: prefs);

    final repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );

    final loginUserUseCase = LoginUser(repository);

    Get.put(AuthController(loginUserUseCase: loginUserUseCase));
  }
}