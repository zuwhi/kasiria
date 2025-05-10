import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/widgets/custom_button_widget.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.tertiary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Container(
                constraints: BoxConstraints(minHeight: heightMedia - 180),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      text: "Bills",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Name",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          text: "Guest",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Date Transaction",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          text: "27/02/2023",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CardProductPayment(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CardProductPayment(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CardProductPayment(),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Subtotal",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          text: "Rp. 15.000",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Discount",
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          color: Colors.grey,
                          text: "Rp. 15.000",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Tax",
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          color: Colors.grey,
                          text: "Rp. 1.000",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      indent: 0,
                      endIndent: 0,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Cash",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          text: "Rp. 1.000",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: "Subtotal",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                        CustomTextWidget(
                          text: "Rp. 15.000",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextWidget(
                          text: "Return",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        SizedBox(
                          height: 30,
                          child: CustomButtonWidget(
                            text: "Rp. 15.000",
                            onPressed: () {},
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: 60,
          child: CustomButtonWidget(
            text: "Print Bills",
            fontSize: 13,
            onPressed: () {},
            borderRadius: 18,
          )),
    );
  }
}

class CardProductPayment extends StatelessWidget {
  const CardProductPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/empty.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "Susu milky choco",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CustomTextWidget(
                      text: "2x",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CustomTextWidget(
                      text: "Rp. 15.000",
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const CustomTextWidget(
          text: "Rp. 15.000",
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      ],
    );
  }
}
