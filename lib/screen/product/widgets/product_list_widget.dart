// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_dialog_confirm.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({
    super.key,
    required this.productState,
    required this.products,
    this.isFiltered = false,
    this.minHeight,
  });

  final AsyncValue<List<ProductModel>> productState;
  final List<ProductModel> products;
  final bool isFiltered;
  final double? minHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProducts =
        products.length > 3 ? products.sublist(0, 3) : products;

    final listProducts = isFiltered ? filteredProducts : products;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextWidget(
                text: "Product List",
                fontSize: 14.0,
              ),
              CustomButtonWidget(
                  text: "+ Add Product",
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  onPressed: () {
                    context.push("/form-product");
                  })
            ],
          ),
        ),
        productState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 10,
                  horizontalMargin: 18,
                  dividerThickness: 0.0000000001,
                  border: TableBorder.all(
                    color: Colors.transparent,
                  ),
                  columns: const [
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Product Name',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Price',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Discount',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'stock',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Edit | Remove',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                  ],
                  rows: listProducts.map((product) {
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          ClipOval(
                            child: product.image == ""
                                ? Image.asset(
                                    "assets/images/placeholder.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(product.image),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Text(product.name),
                        ],
                      )),
                      DataCell(Text('Rp. ${product.price.toString()}')),
                      DataCell(Text('${product.discount.toString()} %')),
                      DataCell(Text(product.stock.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: AppColors.primary),
                            onPressed: () {
                              context.push(
                                '/form-product', // Kirim ID produk sebagai parameter URL
                                extra: product.copyWith(id: product.id),
                              );
                            },
                          ),
                          const Text('|'),
                          IconButton(
                            icon: Icon(Icons.delete, color: AppColors.primary),
                            onPressed: () {
                              customDialogConfirm(
                                  context: context,
                                  title: "Konfirmasi",
                                  content:
                                      'Anda yakin ingin menghapus produk "${product.name}" ?',
                                  onConfirm: () {
                                    ref
                                        .read(productNotifierProvider.notifier)
                                        .deleteProduct(product.id.toString());
                                  });
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
        const SizedBox(
          height: 5.0,
        ),
        isFiltered
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InkWell(
                  onTap: () {
                    context.push("/list-product");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 2, // Space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppColors.primary,
                      width: 2.0, // Underline thickness
                    ))),
                    child: CustomTextWidget(
                      text: "See All",
                      fontSize: 12.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
