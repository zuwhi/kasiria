// import 'dart:io';

// import 'package:kasiria/models/product_model.dart';
// import 'package:kasiria/models/result.dart';
// import 'package:kasiria/services/database_sqflite_service.dart';
// import 'package:kasiria/utils/router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'select_product_provider.g.dart';

// @Riverpod(keepAlive: true);

// class SelectProduct extends _$SelectProduct {
//   @override
//   FutureOr<Result<List<ProductModel>>> build() async {
//     final result = await ref.read(databaseSqfliteServiceProvider).getProduct();
//     return result;
//   }
// }