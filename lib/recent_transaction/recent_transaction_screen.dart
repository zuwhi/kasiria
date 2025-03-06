import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_text_widget.dart';

class RecentTransactionScreen extends ConsumerWidget {
  const RecentTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, String>> transactions = [
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Small',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
      {
        'name': 'Guest',
        'product': 'Coffee Milk Medium',
        'date': '24 Mei 2024',
        'price': 'Rp. 15.000'
      },
    ];

    String getDay() {
      const locale = 'id_ID';
      DateTime now = DateTime.now();
      return DateFormat.EEEE(locale).format(now);
    }

    String getFormattedDate() {
      const locale = 'id_ID';
      DateTime now = DateTime.now();
      return DateFormat("d MMMM yyyy", locale).format(now);
    }

    return Scaffold(
        backgroundColor: AppColors.secondary,
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildHeader(getDay(), getFormattedDate()),
              _buildInfoCard(),
            ],
          ),
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    text: 'Recent Transaction',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  ListView.builder(
                    itemCount: transactions.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _buildTransactionItem(
                        transaction['name']!,
                        transaction['product']!,
                        transaction['date']!,
                        transaction['price']!,
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ])));
  }
}

Widget _buildHeader(String day, String date) {
  return Container(
    height: 200,
    color: AppColors.white,
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CircleAvatar(radius: 25, child: Icon(Icons.people)),
            SizedBox(width: 10.0),
            CustomTextWidget(
              text: 'Admin Cookies',
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 8),
            CustomTextWidget(
              text: day,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            CustomTextWidget(
              text: date,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ],
        )
      ],
    ),
  );
}

Widget _buildInfoCard() {
  return Positioned(
    top: 140,
    left: 20,
    right: 20,
    child: Container(
      height: 120,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionColumn(
                icon: Icons.keyboard_double_arrow_up,
                label: 'Pemasukan hari ini',
                amount: 'Rp. 500.000',
                color: AppColors.neonGreen,
              ),
              _buildTransactionColumn(
                icon: Icons.keyboard_double_arrow_down,
                label: 'Pengeluaran hari ini',
                amount: 'Rp. 100.000',
                color: AppColors.red,
              ),
            ],
          ),
          Column(
            children: [
              _buildTransactionColumn(
                icon: Icons.swap_horiz,
                label: 'Total transaksi hari ini',
                amount: '15',
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildTransactionColumn({
  required IconData icon,
  required String label,
  required String amount,
  required Color color,
}) {
  return Column(
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.softBlue,
            radius: 16,
            child: Icon(icon, color: AppColors.white, size: 30),
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: label,
                fontWeight: FontWeight.w600,
                fontSize: 9,
                color: AppColors.softBlue,
              ),
              CustomTextWidget(
                text: amount,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: color,
              )
            ],
          )
        ],
      ),
    ],
  );
}

Widget _buildTransactionItem(
    String name, String item, String date, String price) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTextWidget(
        text: name,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: item,
            fontSize: 10,
            color: AppColors.grey,
          ),
          CustomTextWidget(
            text: date,
            fontSize: 10,
            color: AppColors.grey,
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: CustomTextWidget(
              text: price,
              fontSize: 10,
              color: AppColors.white,
            ),
          )
        ],
      ),
      const Divider()
    ],
  );
}
