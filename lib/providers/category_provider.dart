import 'dart:io';

import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/result.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/services/database_sqflite_service.dart';
import 'package:kasiria/utils/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@Riverpod(keepAlive: true)
class CategoryNotifier extends _$CategoryNotifier {
  late final DatabaseSqfliteService _databaseSqfliteService;

  @override
  Future<List<CategoryModel>> build() async {
    _databaseSqfliteService = ref.read(databaseSqfliteServiceProvider);
    return await _getCategories();
  }

  Future<List<CategoryModel>> _getCategories() async {
    final Result result = await _databaseSqfliteService.getCategories();
    if (result.isSuccess) {
      return result.resultValue as List<CategoryModel>;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  Future<void> getCategory() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _getCategories();
      state = AsyncValue.data(categories);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addCategory(CategoryModel category, File image, context) async {
    state = const AsyncValue.loading();
    final Result result =
        await _databaseSqfliteService.addCategory(category, image);
    if (result.isSuccess) {
      await getCategory();
      ref.read(routerProvider).go('/manage-product');
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> updateCategory(
      CategoryModel category, File? image, context) async {
    state = const AsyncValue.loading();
    final Result result =
        await _databaseSqfliteService.updateCategory(category, image);
    if (result.isSuccess) {
      await getCategory();
      await ref.watch(productNotifierProvider.notifier).getProduct();
      ref.read(routerProvider).go('/manage-product');
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> deleteCategory(String id) async {
    state = const AsyncValue.loading();
    final Result result = await _databaseSqfliteService.deleteCategory(id);
    if (result.isSuccess) {
      await getCategory();
      await ref.watch(productNotifierProvider.notifier).getProduct();
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }
}
