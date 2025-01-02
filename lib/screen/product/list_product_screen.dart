import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/screen/product/widgets/product_list_widget.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:logger/logger.dart';
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
      ref.read(productNotifierProvider.notifier).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    List<ProductModel> products = productState.value ?? [];
    final NumberPaginatorController pageController =
        NumberPaginatorController();
    int currentPage = 0;
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
                    NumberPaginator(
                      numberPages: 10,
                      onPageChange: (int index) {
                        setState(() {
                          currentPage = index;
                          Logger().d(index);
                        });
                      },

                      showPrevButton: true,
                      showNextButton: false, // defaults to true
                      // custom content of the prev/next buttons, maintains their behavior
                      nextButtonContent: const Icon(Icons.arrow_right_alt),
                      // custom prev/next buttons using builder (ignored if showPrevButton/showNextButton is false)
                      prevButtonBuilder: (context) => TextButton(
                        onPressed: pageController.currentPage > 0
                            ? () => pageController.prev()
                            : null, // _controller must be passed to NumberPaginator
                        child: const Row(
                          children: [
                            Icon(Icons.chevron_left),
                            Text("Previous"),
                          ],
                        ),
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
