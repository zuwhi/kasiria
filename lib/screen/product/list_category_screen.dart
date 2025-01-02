import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/screen/product/widgets/category_list_widget.dart';
import 'package:kasiria/utils/app_colors.dart';

class ListCategoryScreen extends ConsumerStatefulWidget {
  const ListCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListCategoryScreenState();
}

class _ListCategoryScreenState extends ConsumerState<ListCategoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 100,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(18.0),
                child: CategoryListWidget(
                  categoryState: categoryState,
                  categories: categories,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
