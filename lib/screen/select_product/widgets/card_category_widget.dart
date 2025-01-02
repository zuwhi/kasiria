import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class CardCategory extends StatelessWidget {
  final bool isActive;
  final String? imagePath;
  final String? title;
  final int index;
  final void Function()? onTap;

  const CardCategory(
      {super.key,
      this.onTap,
      this.title,
      this.imagePath,
      this.isActive = false,
      this.index = 1});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imagePath != null
                  ? Image.file(
                      File(imagePath!),
                      height: 50.0,
                    )
                  : Image.asset(
                      "assets/images/empty.jpg",
                    ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            CustomTextWidget(
              text: title!,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.white : Colors.grey.shade600,
            )
          ],
        ),
      ),
    );
  }
}
