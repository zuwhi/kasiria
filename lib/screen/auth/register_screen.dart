import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_textformfield_auth.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    usernameController.dispose();
    noTelpController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Regex untuk validasi format email
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormFieldAuth(
                        controller: usernameController,
                        label: "Username",
                        validator: (value) => _validateField(value, "Username"),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormFieldAuth(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email Address",
                        validator: (value) => validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormFieldAuth(
                        controller: noTelpController,
                        label: "Nomor Telpon / Whatsapp",
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            _validateField(value, "Nomor Telpon/Whatsapp"),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormFieldAuth(
                        controller: passwordController,
                        obscureText: true,
                        label: "Password",
                        validator: (value) => validatePassword(value),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormFieldAuth(
                        controller: repasswordController,
                        obscureText: true,
                        label: "Ulangi Password",
                        validator: (value) => validatePassword(value),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: authState.isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : CustomButtonWidget(
                                text: "Register",
                                fontSize: 16,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    ref.read(authProvider.notifier).register(
                                          emailController.text,
                                          passwordController.text,
                                          usernameController.text,
                                          noTelpController.text,
                                        );
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Column(
          children: [
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextWidget(
                  text: "Already have an account?",
                  fontSize: 14,
                ),
                TextButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: CustomTextWidget(
                    text: "Sign in",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
