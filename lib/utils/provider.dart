import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'provider.g.dart';

@riverpod
Client appwriteClient(ref) {
  return Client()
    ..setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
    ..setProject(dotenv.env['APPWRITE_PROJECT_ID']!);
}

@riverpod
Account appwriteAccount(ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
}
