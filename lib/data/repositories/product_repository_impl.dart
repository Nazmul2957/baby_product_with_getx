// lib/data/repositories/product_repository_impl.dart

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_remote_data_source.dart';
import '../datasources/local/product_local_data_source.dart';
import '../../core/errors/failures.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getProducts({int limit = 10, int skip = 0}) async {
    try {
      // Try to get from remote
      final products = await remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );

      // Cache locally
      await localDataSource.cacheProducts(products);

      return products;
    } catch (e) {
      // If remote fails, try local cache
      final cached = await localDataSource.getCachedProducts();
      if (cached.isNotEmpty) {
        return cached;
      } else {
        // If no cache, throw Failure
        throw ServerFailure(e.toString());
      }
    }
  }
}
