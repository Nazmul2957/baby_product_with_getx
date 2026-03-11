// lib/presentation/bindings/product_binding.dart
import 'package:get/get.dart';
import '../../domain/usecases/get_products.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/datasources/local/product_local_data_source.dart';
import '../../core/network/api_client.dart';
import '../../presentation/controllers/product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductBinding extends Bindings {
  @override
  void dependencies() async {
    // SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // ApiClient
    final apiClient = ApiClient(client: http.Client());

    // Data sources
    final remoteDataSource = ProductRemoteDataSourceImpl(apiClient: apiClient);
    final localDataSource = ProductLocalDataSourceImpl(prefs: prefs);

    // Repository
    final repository = ProductRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );

    // Use case
    final getProductsUseCase = GetProducts(repository);

    // Controller
    Get.put(ProductController(getProductsUseCase: getProductsUseCase));
  }
}