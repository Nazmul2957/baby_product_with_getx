// lib/domain/usecases/get_products.dart

import '../repositories/product_repository.dart';
import '../entities/product.dart';
import '../../core/errors/failures.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  /// Fetches product list with pagination
  /// [limit] = items per page
  /// [skip] = offset
  Future<List<Product>> call({int limit = 10, int skip = 0}) async {
    try {
      final products = await repository.getProducts(limit: limit, skip: skip);
      return products;
    } on Failure catch (f) {
      // Re-throw failures to controller
      throw f;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}