import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/screen/select_product/widgets/card_category_widget.dart';

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
      ref.read(productNotifierProvider.notifier).getProduct();
    });
  }

  String categoryName = "";
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoryModel>> categories =
        ref.watch(categoryNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 74,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.value?.length ?? 0,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    CategoryModel category = categories.value![index];
                    return CardCategory(
                      isActive: category.name == categoryName,
                      onTap: () {
                        setState(() {
                          categoryName = category.name;
                        });
                      },
                      imagePath: category.image,
                      title: category.name,
                    );
                  },
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 18.0,
                      childAspectRatio: 0.65),
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
