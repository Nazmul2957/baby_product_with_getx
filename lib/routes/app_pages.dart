// lib/presentation/routes/app_pages.dart
import 'package:get/get.dart';

import '../presentation/bindings/auth_binding.dart';
// lib/presentation/routes/app_pages.dart
import 'package:get/get.dart';

import '../presentation/bindings/product_binding.dart';
import '../presentation/pages/login_screen.dart';
import '../presentation/pages/product_screen.dart';
import '../presentation/pages/splash_screen.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/products',
      page: () => ProductScreen(),
      binding: ProductBinding(),
    ),
  ];
}