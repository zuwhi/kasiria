import 'package:go_router/go_router.dart';
import 'package:kasiria/screen/auth/login_screen.dart';
import 'package:kasiria/screen/auth/register_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
