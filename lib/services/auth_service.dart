import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../models/result.dart';

abstract class IAuthService {
  Future<Result<models.User>> createAccount(
      {required String email, required String password});
}

class AuthService implements IAuthService {
  final Account _account;

  AuthService({required Account account}) : _account = account;

  @override
  Future<Result<models.User>> createAccount({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final user = await _account.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      );

      return Result.success(user);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }
}
