import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_textformfield_auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email Address",
                        validator: (value) => validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormFieldAuth(
                        controller: passwordController,
                        obscureText: true,
                        label: "Password",
                        validator: (value) => validatePassword(value),
                      ),
                      const SizedBox(height: 3),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: CustomTextWidget(
                            text: "Forgot Password ?",
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                text: "Sign in",
                                fontSize: 16,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref.read(authProvider.notifier).login(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                  }
                                },
                              ),
                      ),
                      const SizedBox(height: 25),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomTextWidget(
                              text: "or",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/icon_google.png',
                              height: 35,
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/icon_fb.png',
                              height: 35,
                            ),
                          ),
                        ],
                      )
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
                  text: "Don't have an account?",
                  fontSize: 14,
                ),
                TextButton(
                  onPressed: () {
                    context.go("/register");
                  },
                  child: CustomTextWidget(
                    text: "Register",
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
