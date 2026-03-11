// lib/presentation/controllers/product_controller.dart

import 'package:get/get.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/entities/product.dart';
import '../../core/errors/failures.dart';

class ProductController extends GetxController {
  final GetProducts getProductsUseCase;

  ProductController({required this.getProductsUseCase});

  RxList<Product> products = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  int limit = 10;
  int skip = 0;
  RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts({bool isLoadMore = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = "";

    try {
      final result = await getProductsUseCase(limit: limit, skip: skip);

      if (isLoadMore) {
        products.addAll(result);
      } else {
        products.assignAll(result);
      }

      // Pagination check
      hasMore.value = result.length >= limit;
      if (hasMore.value) skip += limit;
    } on Failure catch (f) {
      errorMessage.value = f.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void refreshProducts() {
    skip = 0;
    hasMore.value = true;
    fetchProducts();
  }
}