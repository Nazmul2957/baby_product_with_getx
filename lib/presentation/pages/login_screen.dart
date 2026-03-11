// lib/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : AppColors.background,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 24),
            if (controller.isLoading.value)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  controller.login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ).then((_) {
                    if (controller.errorMessage.value.isEmpty) {
                      Get.offNamed('/products');
                    }
                  });
                },
                child: const Text("Login"),
              ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        )),
      ),
    );
  }
}