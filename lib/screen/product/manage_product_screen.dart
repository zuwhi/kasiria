import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/screen/product/widgets/category_list_widget.dart';
import 'package:kasiria/screen/product/widgets/product_list_widget.dart';
import 'package:kasiria/utils/app_colors.dart';

class ManageProductScreen extends ConsumerStatefulWidget {
  const ManageProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageProductScreenState();
}

class _ManageProductScreenState extends ConsumerState<ManageProductScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productNotifierProvider.notifier).getProduct();
      ref.read(categoryNotifierProvider.notifier).getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    List<ProductModel> products = productState.value ?? [];

    final categoryState = ref.watch(categoryNotifierProvider);
    List<CategoryModel> categories = categoryState.value ?? [];
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: CategoryListWidget(
                  categoryState: categoryState,
                  categories: categories,
                  isFiltered: true,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: ProductListWidget(
                  productState: productState,
                  products: products,
                  isFiltered: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
