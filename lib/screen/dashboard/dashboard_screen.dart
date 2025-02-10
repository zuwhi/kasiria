import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/utils/router.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomButtonWidget(
                  text: "ADD PRODUCT",
                  onPressed: () {
                    ref.read(routerProvider).push('/manage-product');
                  }),
              const SizedBox(
                height: 30.0,
              ),
              CustomButtonWidget(
                  text: "SELECT PRODUCT",
                  onPressed: () {
                    ref.read(routerProvider).push('/select-product');
                  }),
              const SizedBox(
                height: 30.0,
              ),
              CustomButtonWidget(
                  text: "PAYMENT UI",
                  onPressed: () {
                    ref.read(routerProvider).push('/payment');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
