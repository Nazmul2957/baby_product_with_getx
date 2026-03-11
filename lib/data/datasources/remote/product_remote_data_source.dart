// lib/data/datasources/remote/product_remote_data_source.dart

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int limit, int skip});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({int limit = 10, int skip = 0}) async {
    try {
      final response = await apiClient.get(
        "${ApiEndpoints.products}?limit=$limit&skip=$skip",
      );

      // Assuming response is like { "products": [ {...}, {...} ] }
      final products = (response['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return products;
    } on Exception catch (e) {
      throw e; // Will be handled in repository via ErrorHandler
    }
  }
}
