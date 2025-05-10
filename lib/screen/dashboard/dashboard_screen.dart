import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:kasiria/utils/app_colors.dart';
import 'package:kasiria/utils/router.dart';
import 'package:kasiria/widgets/custom_text_widget.dart';

import '../../providers/auth_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value;
    List<Map<String, dynamic>> menuItems = [
      {
        'title': 'POS',
        'subtitle': 'lorem ipsum lorem ipsum',
        'icon': 'assets/images/icon_pos.png',
        'route': () {
          ref.read(routerProvider).push('/manage-product');
        },
        'isPro': false
      },
      {
        'title': 'Manajemen Produk',
        'subtitle': 'lorem ipsum lorem ipsum',
        'icon': 'assets/images/icon_manajemen_produk.png',
        'route': () {
          ref.read(routerProvider).push('/manage-product');
        },
        'isPro': false
      },
      {
        'title': 'Analisis Produk',
        'subtitle': 'lorem ipsum lorem ipsum',
        'icon': 'assets/images/icon_analisis_produk.png',
        'route': () {
          ref.read(routerProvider).push('/select-product');
        },
        'isPro': true
      },
      {
        'title': 'Chat Bot',
        'subtitle': 'lorem ipsum lorem ipsum',
        'icon': 'assets/images/icon_chat_bot.png',
        'route': () {
          ref.read(routerProvider).push('/payment');
        },
        'isPro': false
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
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeader(
                    user?.username ?? 'Guest', getDay(), getFormattedDate()),
                _buildInfoCard(),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 160,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextWidget(
                          text: 'Recent Transaction',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        InkWell(
                          onTap: () {
                            ref
                                .read(routerProvider)
                                .push('/recent-transaction');
                          },
                          child: CustomTextWidget(
                            text: 'See All',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            isUnderlined: true,
                            underlineColor: AppColors.primary,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    _buildTransactionItem('Guest', 'Coffee Milk Small',
                        '24 Mei 2024', 'Rp. 15.000'),
                    _buildTransactionItem('Guest', 'Coffee Milk Medium',
                        '24 Mei 2024', 'Rp. 15.000'),
                  ]),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItem(menuItems[index]);
                  },
                )),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(String username, String day, String date) {
  return Container(
    height: 200,
    color: AppColors.white,
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 25, child: Icon(Icons.people)),
            const SizedBox(width: 10.0),
            CustomTextWidget(
              text: username,
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

Widget _buildMenuItem(Map<String, dynamic> item) {
  return InkWell(
    onTap: item['route'],
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item['icon'],
                height: 55,
              ),
              const SizedBox(height: 10),
              CustomTextWidget(
                text: item['title'],
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 4),
              CustomTextWidget(
                text: item['subtitle'],
                fontSize: 10,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        if (item['isPro'])
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: CustomTextWidget(
                text: 'Pro',
                fontSize: 10,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}
