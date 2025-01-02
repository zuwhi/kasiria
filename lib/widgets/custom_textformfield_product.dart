import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasiria/utils/app_colors.dart';

class CustomTextFormFieldProduct extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFormFieldProduct({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      minLines: 1,
      maxLines: null,
      expands: false,
      decoration: InputDecoration(
        fillColor: AppColors.secondary,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
    );
  }
}
