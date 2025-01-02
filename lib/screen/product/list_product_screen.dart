import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/product_length_provider.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/screen/product/widgets/product_list_widget.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:number_paginator/number_paginator.dart';

class ListProductScreen extends ConsumerStatefulWidget {
  const ListProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListProductScreenState();
}

class _ListProductScreenState extends ConsumerState<ListProductScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProducts();
      ref.read(productLengthNotifierProvider.notifier).refreshProductCount();
    });
  }

  int currentPage = 0;
  int pageSize = 10;

  void fetchProducts() {
    int offset = currentPage * pageSize;
    ref.read(productNotifierProvider.notifier).getProduct(
          limit: pageSize,
          offset: offset,
        );
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    final productLength = ref.watch(productLengthNotifierProvider);
    List<ProductModel> products = productState.value ?? [];
    final NumberPaginatorController pageController =
        NumberPaginatorController();

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
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductListWidget(
                      productState: productState,
                      products: products,
                      minHeight: MediaQuery.of(context).size.height - 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Row(
                        children: [
                          CustomButtonWidget(
                              text: "Export to CSV",
                              onPressed: () {},
                              color: AppColors.green,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16)),
                          Flexible(
                            child: NumberPaginator(
                              config: NumberPaginatorUIConfig(
                                  buttonSelectedBackgroundColor:
                                      AppColors.primary,
                                  buttonShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              numberPages:
                                  ((productLength.value ?? 0) / pageSize)
                                      .ceil(),
                              controller: pageController,
                              onPageChange: (int index) {
                                setState(() {
                                  currentPage = index;
                                });
                                fetchProducts();
                              },
                              showPrevButton: true,
                              showNextButton: true,
                              nextButtonContent:
                                  const Icon(Icons.chevron_right),
                              prevButtonContent: const Icon(Icons.chevron_left),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
