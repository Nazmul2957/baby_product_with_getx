// lib/domain/repositories/product_repository.dart
import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({int limit, int skip});
}