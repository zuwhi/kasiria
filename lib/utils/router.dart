import 'package:go_router/go_router.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/screen/auth/login_screen.dart';
import 'package:kasiria/screen/auth/register_screen.dart';
import 'package:kasiria/screen/product/form_category_screen.dart';
import 'package:kasiria/screen/product/form_product_screen.dart';
import 'package:kasiria/screen/product/list_category_screen.dart';
import 'package:kasiria/screen/product/list_product_screen.dart';
import 'package:kasiria/screen/product/manage_product_screen.dart';
import 'package:kasiria/screen/select_product/select_product_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
      initialLocation: '/manage-product',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/manage-product',
          builder: (context, state) => const ManageProductScreen(),
        ),
        GoRoute(
          path: '/form-product',
          builder: (context, state) {
            final product = state.extra as ProductModel?;
            return FormProductScreen(product: product);
          },
        ),
        GoRoute(
          path: '/form-category',
          builder: (context, state) {
            final category = state.extra as CategoryModel?;
            return FormCategoryScreen(
              category: category,
            );
          },
        ),
        GoRoute(
          path: '/list-product',
          builder: (context, state) => const ListProductScreen(),
        ),
        GoRoute(
          path: '/list-category',
          builder: (context, state) => const ListCategoryScreen(),
        ),
        GoRoute(
          path: '/select-product',
          builder: (context, state) => const SelectProductScreen(),
        ),
      ],
    ));
