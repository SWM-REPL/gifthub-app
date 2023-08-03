import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/providers/dio.provider.dart';
import 'package:gifthub/apis/products.api.dart';

@immutable
class Product {
  final int id;
  final String brand;
  final String imageUrl;
  final String name;
  final int price;
  final String description;

  const Product({
    required this.id,
    required this.brand,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['brand'],
        imageUrl = json['image_url'],
        name = json['name'],
        price = json['price'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'image_url': imageUrl,
        'name': name,
        'price': price,
        'description': description,
      };
}

class ProductNotifier extends AsyncNotifier<Map<int, Product>> {
  late final Dio _dio;

  @override
  Future<Map<int, Product>> build() async {
    _dio = ref.watch(dioProvider);
    return {};
  }

  Future<Product> get(
    int id,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.value!.containsKey(id)) {
        return state.value!;
      } else {
        final product = await ProductsApi.fetchProduct(_dio, id);
        return {
          ...state.value!,
          product.id: product,
        };
      }
    });
    return state.value![id]!;
  }
}

final productProvider =
    AsyncNotifierProvider<ProductNotifier, Map<int, Product>>(
  () => ProductNotifier(),
);
