import 'package:kasiria/services/database_sqflite_service.dart';
import 'package:kasiria/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_length_provider.g.dart';

@Riverpod(keepAlive: true)
class CategoryLengthNotifier extends _$CategoryLengthNotifier {
  late final DatabaseSqfliteService _databaseSqfliteService;

  @override
  Future<int> build() async {
    _databaseSqfliteService = ref.read(databaseSqfliteServiceProvider);
    return await _getCategoryCount();
  }

  Future<int> _getCategoryCount() async {
    final Result result = await _databaseSqfliteService.getCategoryCount();
    if (result.isSuccess) {
      return result.resultValue as int;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  Future<void> refreshCategoryCount() async {
    state = const AsyncValue.loading();
    try {
      final count = await _getCategoryCount();
      state = AsyncValue.data(count);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
