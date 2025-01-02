import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/models/result.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final databaseSqfliteServiceProvider = Provider<DatabaseSqfliteService>((ref) {
  return DatabaseSqfliteService();
});

class DatabaseSqfliteService {
  static Database? _database;
  static const String productTable = 'products';
  static const String categoryTable = 'categories';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $categoryTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            image TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE $productTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price INTEGER,
            discount INTEGER,
            stock INTEGER,
            category TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<String> _saveImageLocally(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  Future<Result> addCategory(CategoryModel category, File imageFile) async {
    try {
      final savedImagePath = await _saveImageLocally(imageFile);
      final db = await database;

      await db.insert(
        categoryTable,
        {'name': category.name, 'image': savedImagePath},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> getCategories() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(categoryTable);
      final List<CategoryModel> categories =
          maps.map((map) => CategoryModel.fromJson(map)).toList();
      return Result.success(categories);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> updateCategory(CategoryModel category, File? imageFile) async {
    try {
      String imagePath = category.image;
      if (imageFile != null) {
        imagePath = await _saveImageLocally(imageFile);
      }

      final updatedCategory = category.copyWith(image: imagePath);
      final db = await database;

      await db.update(
        categoryTable,
        updatedCategory.toJson(),
        where: 'id = ?',
        whereArgs: [category.id],
      );

      await db.update(
        productTable,
        {'category': updatedCategory.id},
        where: 'category = ?',
        whereArgs: [category.id],
      );

      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> deleteCategory(String id) async {
    try {
      final db = await database;
      await db.update(
        productTable,
        {'category': 'Uncategorized'},
        where: 'category = ?',
        whereArgs: [id],
      );

      await db.delete(
        categoryTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      return const Result.success(null);
    } catch (e) {
      Logger().e(e);
      return Result.failed(e.toString());
    }
  }

  Future<Result> addProduct(ProductModel product, File imageFile) async {
    try {
      final savedImagePath = await _saveImageLocally(imageFile);

      // Buat objek produk baru tanpa ID
      final newProduct = product.copyWith(image: savedImagePath);

      final db = await database;
      await db.insert(
        productTable,
        {
          'name': newProduct.name,
          'price': newProduct.price,
          'discount': newProduct.discount,
          'stock': newProduct.stock,
          'category': newProduct.category,
          'image': newProduct.image,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<int> getProductCount() async {
    try {
      final db = await database;

      // Menghitung jumlah baris dalam tabel productTable
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $productTable'),
      );

      return count ?? 0; // Mengembalikan 0 jika data kosong
    } catch (e) {
      return 0;
    }
  }

  Future<Result> getProducts({int limit = 10, int offset = 0}) async {
    try {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query(
        productTable,
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );

      final List<ProductModel> products = maps.map((map) {
        return ProductModel.fromJson({...map, 'id': map['id'] as int?});
      }).toList();

      return Result.success(products);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> updateProduct(ProductModel product, File? imageFile) async {
    try {
      String imagePath = product.image;
      if (imageFile != null) {
        imagePath = await _saveImageLocally(imageFile);
      }

      final updatedProduct = product.copyWith(image: imagePath);
      final db = await database;

      await db.update(
        productTable,
        updatedProduct.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      return const Result.success(null);
    } catch (e) {
      Logger().e(e);
      return Result.failed(e.toString());
    }
  }

  Future<Result> deleteProduct(String id) async {
    try {
      final db = await database;
      await db.delete(
        productTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
