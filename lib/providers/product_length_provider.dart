import 'package:kasiria/services/database_sqflite_service.dart';
import 'package:kasiria/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_length_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductLengthNotifier extends _$ProductLengthNotifier {
  late final DatabaseSqfliteService _databaseSqfliteService;

  @override
  Future<int> build() async {
    _databaseSqfliteService = ref.read(databaseSqfliteServiceProvider);
    return await _getProductCount();
  }

  Future<int> _getProductCount() async {
    final Result result = await _databaseSqfliteService.getProductCount();
    if (result.isSuccess) {
      return result.resultValue as int;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  Future<void> refreshProductCount() async {
    state = const AsyncValue.loading();
    try {
      final count = await _getProductCount();
      state = AsyncValue.data(count);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
