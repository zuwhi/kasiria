import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/providers/product_provider.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';
import 'package:kasiria/widgets/custom_textformfield_product.dart';
import 'package:logger/logger.dart';

class FormProductScreen extends ConsumerStatefulWidget {
  final ProductModel? product;

  const FormProductScreen({super.key, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormProductScreenState();
}

class _FormProductScreenState extends ConsumerState<FormProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  File? image;
  final picker = ImagePicker();
  bool _imageError = false;

  String? selectedCategoryId;

  // Fungsi ambil gambar
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        _imageError = false;
      });
    }
  }

  // Validasi
  String? _validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Inisialisasi data jika update
  void _initializeData() {
    if (widget.product != null) {
      productNameController.text = widget.product!.name;
      priceController.text = widget.product!.price.toString();
      discountController.text = widget.product!.discount.toString();
      stockController.text = widget.product!.stock.toString();
      selectedCategoryId = widget.product!.category;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).getCategory();
    });

    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryNotifierProvider);
    List<CategoryModel> categories = categoryState.value ?? [];

    bool isUpdate = widget.product != null;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: isUpdate ? "Update Product" : "Add Product",
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 20.0),

                      Row(
                        children: [
                          _buildLabel("Product Name"),
                          Flexible(
                            child: CustomTextFormFieldProduct(
                              controller: productNameController,
                              validator: (value) =>
                                  _validateField(value, "Product Name"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          _buildLabel("Price"),
                          Flexible(
                            child: CustomTextFormFieldProduct(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validateField(value, "Price"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          _buildLabel("Discount"),
                          Flexible(
                            child: CustomTextFormFieldProduct(
                              controller: discountController,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validateField(value, "Discount"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          _buildLabel("Stock"),
                          Flexible(
                            child: CustomTextFormFieldProduct(
                              controller: stockController,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validateField(value, "Stock"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          _buildLabel("Category"),
                          Flexible(
                              child: DropdownButton<String>(
                            value: selectedCategoryId,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategoryId = newValue;
                              });
                            },
                            items: [
                              ...categories
                                  .map<DropdownMenuItem<String>>((category) {
                                return DropdownMenuItem<String>(
                                  value: category.id.toString(),
                                  child: Text(category.name),
                                );
                              }),
                              // Tambahkan Uncategorized jika nilainya tidak ada dalam daftar
                              if (!categories.any((category) =>
                                  category.id == selectedCategoryId))
                                const DropdownMenuItem<String>(
                                  value: 'Uncategorized',
                                  child: Text('Uncategorized'),
                                ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Gambar Produk
                      const CustomTextWidget(
                        text: "Image",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 15.0),
                      InkWell(
                        onTap: pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color:
                                  _imageError ? Colors.red : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: image != null
                              ? Image.file(image!, fit: BoxFit.cover)
                              : widget.product != null
                                  ? Image.file(File(widget.product!.image),
                                      fit: BoxFit.cover)
                                  : const Center(child: Text("Upload Image")),
                        ),
                      ),
                      const SizedBox(height: 28.0),
                      CustomButtonWidget(
                        text: isUpdate ? "Update" : "Save",
                        borderRadius: 15,
                        onPressed: () {
                          try {
                            setState(() {
                              isUpdate ? null : _imageError = image == null;
                            });
                            if (_formKey.currentState!.validate() &&
                                !_imageError) {
                              ProductModel productModel = ProductModel(
                                name: productNameController.text,
                                price: int.parse(priceController.text),
                                discount: int.parse(discountController.text),
                                stock: int.parse(stockController.text),
                                category: selectedCategoryId ?? "Uncategorized",
                                image: "",
                              );

                              if (isUpdate) {
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .updateProduct(
                                        productModel.copyWith(
                                            id: widget.product!.id,
                                            image: widget.product!.image),
                                        image,
                                        context);
                              } else {
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .addProduct(productModel, image!, context);
                              }
                            }
                          } catch (e) {
                            Logger().e(e);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return SizedBox(
      width: 100,
      child: CustomTextWidget(
        text: text,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
