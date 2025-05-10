import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/screen/select_product/widgets/card_category_widget.dart';
import 'package:kasiria/screen/select_product/widgets/card_product_widget.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';

class SelectProductScreen extends ConsumerStatefulWidget {
  const SelectProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectProductScreenState();
}

class _SelectProductScreenState extends ConsumerState<SelectProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).getCategory();
      ref
          .read(productNotifierProvider.notifier)
          .getProductsByCategory(categoryName);
    });
  }

  String categoryName = "All";

  Future<void> setCategory(String selectedCategory, String categoryId) async {
    categoryName = selectedCategory;
    await ref
        .read(productNotifierProvider.notifier)
        .getProductsByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoryModel>> categories =
        ref.watch(categoryNotifierProvider);
    final AsyncValue<List<ProductModel>> products =
        ref.watch(productNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.tertiary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: (categories.value?.length ?? 0) + 1,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: CardCategory(
                          isActive: categoryName == "All",
                          onTap: () {
                            setState(() {
                              categoryName = "All";
                              setCategory("All", "All");
                            });
                          },
                          imageAsset: 'assets/images/logo_white.png',
                          title: 'All',
                        ),
                      );
                    }

                    CategoryModel category = categories.value![index - 1];
                    return Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: CardCategory(
                        isActive: category.name == categoryName,
                        onTap: () {
                          setState(() {
                            setCategory(category.name, category.id.toString());
                          });
                        },
                        imagePath: category.image,
                        title: category.name,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 27.0,
              ),
              GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 0.98),
                  itemCount: products.value?.length ?? 0,
                  itemBuilder: (context, index) {
                    ProductModel product = products.value![index];
                    return CardProductWidget(product: product);
                  })
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: 50,
          child: CustomButtonWidget(text: "Payment", onPressed: () {})),
    );
  }
}
