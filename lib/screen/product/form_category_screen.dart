import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasiria/models/category_model.dart';
import 'package:kasiria/providers/category_provider.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';
import 'package:kasiria/widgets/custom_textformfield_product.dart';

class FormCategoryScreen extends ConsumerStatefulWidget {
  final CategoryModel? category; // Parameter opsional untuk update

  const FormCategoryScreen({super.key, this.category}); // Tambah parameter

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormCategoryScreenState();
}

class _FormCategoryScreenState extends ConsumerState<FormCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  File? image;
  final picker = ImagePicker();
  bool _imageError = false;

  @override
  void initState() {
    super.initState();

    // Jika parameter 'category' ada, isi nilai default untuk update
    if (widget.category != null) {
      productNameController.text = widget.category!.name;
      image = widget.category!.image.isNotEmpty
          ? File(widget.category!.image) // Gambar dari path jika tersedia
          : null;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        _imageError = false;
      });
    }
  }

  String? _validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category Name is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.category != null; // Cek mode update atau tambah

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
                        text: isUpdate ? "Edit Category" : "Add Category",
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: const CustomTextWidget(
                              text: "Category Name",
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: CustomTextFormFieldProduct(
                              controller: productNameController,
                              validator: _validateProductName,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
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
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.file(image!, fit: BoxFit.cover))
                              : const Center(
                                  child: CustomTextWidget(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    text: "Upload Image",
                                  ),
                                ),
                        ),
                      ),
                      if (_imageError)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Image is required',
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          ),
                        ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                const SizedBox(height: 28.0),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: CustomButtonWidget(
                    text: isUpdate ? "Update" : "Save", // Ubah label tombol
                    borderRadius: 15,
                    onPressed: () {
                      setState(() {
                        _imageError = image == null;
                      });
                      if (_formKey.currentState!.validate() && !_imageError) {
                        if (isUpdate) {
                          // Proses Update
                          CategoryModel updatedCategory = CategoryModel(
                            id: widget.category!.id, // Pertahankan ID yang sama
                            name: productNameController.text,
                            image: image!.path,
                          );

                          ref
                              .read(categoryNotifierProvider.notifier)
                              .updateCategory(updatedCategory, image!, context);
                        } else {
                          // Proses Tambah
                          CategoryModel newCategory = CategoryModel(
                            name: productNameController.text,
                            image: image!.path,
                          );

                          ref
                              .read(categoryNotifierProvider.notifier)
                              .addCategory(newCategory, image!, context);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
