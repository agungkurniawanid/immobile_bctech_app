import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/const/const_color.dart';
import 'package:immobile_bctech_app/screens/auth/login_screen.dart';
import 'package:immobile_bctech_app/widgets/widget_menu_card.dart';
import 'package:immobile_bctech_app/widgets/widget_stock.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': FontAwesomeIcons.box,
        'title': 'In',
        'color': Colors.red,
        'page': null,
      },
      {
        'icon': FontAwesomeIcons.arrowRightFromBracket,
        'title': 'Out',
        'color': primaryColor,
        'page': LoginScreen(),
      },
      {
        'icon': FontAwesomeIcons.truck,
        'title': 'Stock Take',
        'color': Colors.indigoAccent,
        'page': null,
      },
      {
        'icon': FontAwesomeIcons.ellipsisH,
        'title': 'More',
        'color': Colors.purpleAccent,
        'page': null,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Good Day,\n',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Mr. Warehouse\n',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    WidgetSpan(child: SizedBox(height: 30)),
                                    TextSpan(
                                      text: 'App Version 1.0.0',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                FontAwesomeIcons.solidBell,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.85,
                              ),
                          itemCount: menuItems.length,
                          itemBuilder: (_, index) {
                            final menuItem = menuItems[index];
                            return WidgetMenuCard(
                              icon: menuItem['icon'],
                              title: menuItem['title'],
                              color: menuItem['color'],
                              page: menuItem['page'],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  'Recent Stock Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 12,
                    children: List.generate(10, (index) => const WidgetStock()),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Recent Purchase Orders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 12,
                    children: List.generate(
                      10,
                      (index) => const WidgetStock(
                        titlePODate: 'SO Date:',
                        date: '4 April 2025',
                        titleTotalItem: 'Customer:',
                        totalItem: '3',
                        titleTotalQty: 'Total Item:',
                        totalQty: '15',
                        id: 'SO2762282500001',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
