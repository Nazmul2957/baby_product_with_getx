// lib/data/datasources/local/product_local_data_source.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/storage_key.dart';
import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences prefs;

  ProductLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonString = jsonEncode(products.map((e) => e.toJson()).toList());
    await prefs.setString(StorageKeys.cachedProducts, jsonString);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = prefs.getString(StorageKeys.cachedProducts);
    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => ProductModel.fromJson(e)).toList();
  }
}