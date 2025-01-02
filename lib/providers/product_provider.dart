import 'dart:io';

import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/models/result.dart';
import 'package:kasiria/services/database_sqflite_service.dart';
import 'package:kasiria/utils/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductNotifier extends _$ProductNotifier {
  late final DatabaseSqfliteService _databaseSqfliteService;

  @override
  Future<List<ProductModel>> build() async {
    _databaseSqfliteService = ref.read(databaseSqfliteServiceProvider);
    return await _getProducts();
  }

  Future<List<ProductModel>> _getProducts({int limit = 5, int offset = 0}) async {
    final Result result = await _databaseSqfliteService.getProducts(limit:limit,offset: offset);
    if (result.isSuccess) {
      return result.resultValue as List<ProductModel>;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  Future<void> getProduct({int limit = 5, int offset = 0}) async {
    state = const AsyncValue.loading();
    try {
      final products = await _getProducts( limit:limit,offset: offset);
      state = AsyncValue.data(products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addProduct(ProductModel product, File image, context) async {
    state = const AsyncValue.loading();
    final Result result =
        await _databaseSqfliteService.addProduct(product, image);
    if (result.isSuccess) {
      await getProduct();
      ref.read(routerProvider).go('/list-product');
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> updateProduct(ProductModel product, File? image, context) async {
    state = const AsyncValue.loading();
    final Result result =
        await _databaseSqfliteService.updateProduct(product, image);
    if (result.isSuccess) {
      await getProduct();
      ref.read(routerProvider).go('/list-product');
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    final Result result = await _databaseSqfliteService.deleteProduct(id);
    if (result.isSuccess) {
      await getProduct();
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }
}
