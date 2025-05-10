import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class CardCategory extends StatelessWidget {
  final bool isActive;
  final String? imagePath;
  final String? title;
  final String? imageAsset;
  final int index;
  final void Function()? onTap;

  const CardCategory(
      {super.key,
      this.onTap,
      this.title,
      this.imagePath,
      this.imageAsset,
      this.isActive = false,
      this.index = 1});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                height: 35.0,
                width: 35.0,
                child: imageAsset != null
                    ? Image.asset(
                        imageAsset!,
                        fit: BoxFit.cover,
                      )
                    : imagePath != null
                        ? Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/empty.jpg",
                          ),
              ),
            ),
            SizedBox(
              width: 53,
              child: Center(
                child: CustomTextWidget(
                  text: title!,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppColors.white : Colors.grey.shade600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
