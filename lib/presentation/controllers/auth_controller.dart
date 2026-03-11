// lib/presentation/controllers/auth_controller.dart
import 'package:get/get.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user.dart';
import '../../core/errors/failures.dart';

class AuthController extends GetxController {
  final LoginUser loginUserUseCase;

  AuthController({required this.loginUserUseCase});

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  // Login method
  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      final result = await loginUserUseCase(email: email, password: password);
      user.value = result;
      // Navigate to home page
      Get.offNamed('/products');
    } on Failure catch (f) {
      errorMessage.value = f.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Check if token exists and valid
  Future<void> checkToken() async {
    isLoading.value = true;
    try {
      final token = await loginUserUseCase.repository.getToken();
      if (token != null && token.isNotEmpty) {
        // Token exists → go to home page
        user.value = User(id: 0, name: "User", email: "", token: token);
        Get.offNamed('/products');
      } else {
        // No token → stay at login
        Get.offNamed('/login');
      }
    } catch (_) {
      Get.offNamed('/login');
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    await loginUserUseCase.repository.logout();
    user.value = null;
    Get.offAllNamed('/login');
  }
}