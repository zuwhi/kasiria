import 'dart:convert';

import 'package:appwrite/models.dart' as models;
import 'package:crypto/crypto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/result.dart';
import '../services/database_sqflite_service.dart';
import '../utils/provider.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/router.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  late final AuthService _authService =
      AuthService(account: ref.read(appwriteAccountProvider));
  late final DatabaseSqfliteService _databaseSqfliteService;

  @override
  Future<UserModel?> build() async {
    _databaseSqfliteService = ref.read(databaseSqfliteServiceProvider);
    return null;
  }

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<void> register(
    String email,
    String password,
    String username,
    String noTelp,
  ) async {
    state = const AsyncValue.loading();

    final authResult = await _authService.createAccount(
        email: email, password: password, name: username);
    String encryptedPassword = encryptPassword(password);
    if (authResult.isSuccess) {
      final userId = authResult.resultValue?.$id ?? '';
      final userModel = UserModel(
        id: userId,
        username: username,
        email: email,
        password: encryptedPassword,
        noTelp: noTelp,
      );
      final Result result =
          await _databaseSqfliteService.registerUser(userModel);
      if (result.isSuccess) {
        ref.read(routerProvider).go('/login');
      } else {
        state = AsyncValue.error(result.errorMessage!, StackTrace.current);
      }
    } else {
      state = AsyncValue.error(authResult.errorMessage!, StackTrace.current);
      resetState();
    }
  }

  void resetState() async {
    Future.delayed(const Duration(seconds: 1), () {
      state = const AsyncValue.data(null);
    });
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _databaseSqfliteService.getUserByEmail(email);
      if (user == null) {
        state = AsyncValue.error("User tidak ditemukan", StackTrace.current);
        return;
      }
      String encryptedInputPassword = encryptPassword(password);
      if (user.password != encryptedInputPassword) {
        state = AsyncValue.error("Password salah", StackTrace.current);
        return;
      }
      state = AsyncValue.data(user);
      ref.read(routerProvider).go('/dashboard');
    } catch (e) {
      state =
          AsyncValue.error("Terjadi kesalahan saat login", StackTrace.current);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();

    try {
      state = const AsyncValue.data(null);
      ref.read(routerProvider).go('/login');
    } catch (e) {
      state =
          AsyncValue.error("Terjadi kesalahan saat logout", StackTrace.current);
    }
  }
}
