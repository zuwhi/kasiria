import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasiria/models/product_model.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
            const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(14.0)),
                      child: Image.file(
                        File(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomTextWidget(
                    text: product.name,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomTextWidget(
                    text: "Rp. ${product.price.toString()}",
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 38.0,
                      child: CustomTextWidget(
                        text: "Quantity",
                        fontSize: 8.0,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CustomButtonWidget(
                              borderRadius: 5,
                              text: "-",
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              onPressed: () {}),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomTextWidget(
                            text: "10",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CustomButtonWidget(
                              borderRadius: 5,
                              text: "+",
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 35.0,
                    ),
                  ],
                ),
              )
            ]));
  }
}
