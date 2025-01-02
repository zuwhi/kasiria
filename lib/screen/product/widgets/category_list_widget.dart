// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_dialog_confirm.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class CategoryListWidget extends ConsumerWidget {
  const CategoryListWidget({
    super.key,
    required this.categoryState,
    required this.categories,
    this.isFiltered = false,
  });

  final AsyncValue<List<CategoryModel>> categoryState;
  final List<CategoryModel> categories;
  final bool isFiltered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCategories =
        categories.length > 3 ? categories.sublist(0, 3) : categories;

    final listCategories = isFiltered ? filteredCategories : categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextWidget(
                text: "Category List",
                fontSize: 14.0,
              ),
              SizedBox(
                child: CustomButtonWidget(
                    text: "+ Add Category",
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    onPressed: () {
                      context.push("/form-category");
                    }),
              )
            ],
          ),
        ),
        categoryState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 25,
                  horizontalMargin: 0,
                  dividerThickness: 0.0000000001,
                  border: TableBorder.all(
                    color: Colors.transparent,
                  ),
                  columns: const [
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Category Name',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                    )),
                    DataColumn(
                        label: CustomTextWidget(
                      text: 'Total Products',
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
                  rows: listCategories.map((category) {
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          ClipOval(
                            child: category.image == ""
                                ? Image.asset(
                                    "assets/images/placeholder.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(category.image),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Text(category.name),
                        ],
                      )),
                      DataCell(Text(category.id.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: AppColors.primary),
                            onPressed: () {
                              context.push("/form-category", extra: category);
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
                                      'Anda yakin ingin menghapus category "${category.name}" ?',
                                  onConfirm: () {
                                    ref
                                        .read(categoryNotifierProvider.notifier)
                                        .deleteCategory(category.id.toString());
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
                    context.push("/list-category");
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
