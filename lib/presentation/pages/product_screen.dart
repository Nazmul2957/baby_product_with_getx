// lib/presentation/screens/product_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/theme_controller.dart';
import '../controllers/product_controller.dart';
import '../../core/theme/app_colors.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController controller = Get.find();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          controller.hasMore.value) {
        controller.fetchProducts(isLoadMore: true);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Baby Products"),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshProducts();
          },
          child: ListView.builder(
            controller: scrollController,
            itemCount: controller.products.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.products.length) {
                // Loading indicator for pagination
                return controller.hasMore.value
                    ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }

              final product = controller.products[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}