import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/screens/dashboard/dashboard_screen.dart';
import 'package:immobile_bctech_app/screens/history/history_screen.dart';
import 'package:immobile_bctech_app/screens/profile/profile_screen.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class NavigationController extends ConsumerStatefulWidget {
  const NavigationController({super.key});

  @override
  ConsumerState<NavigationController> createState() =>
      _NavigationControllerState();
}

class _NavigationControllerState extends ConsumerState<NavigationController> {
  late PageController _pageController;
  final int itemCount = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ref.read(bottomNavIndexProvider),
    );
  }

  void _onPageChanged(int index) {
    ref.read(bottomNavIndexProvider.notifier).state = index;
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    ref.read(bottomNavIndexProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final primaryColor = ref.watch(primaryColorProvider);

    final pages = [
      const DashboardScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left:
                  (screenWidth / itemCount) * currentIndex +
                  (screenWidth / itemCount - 40) / 2.8,
              top: 0,
              child: Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.6),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  inactiveIcon: FontAwesomeIcons.house,
                  activeIcon: FontAwesomeIcons.solidHouse,
                  isActive: currentIndex == 0,
                  onTap: _onItemTapped,
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  inactiveIcon: FontAwesomeIcons.fileLines,
                  activeIcon: FontAwesomeIcons.solidFileLines,
                  isActive: currentIndex == 1,
                  onTap: _onItemTapped,
                ),
                _buildNavItem(
                  context,
                  index: 2,
                  inactiveIcon: FontAwesomeIcons.user,
                  activeIcon: FontAwesomeIcons.solidUser,
                  isActive: currentIndex == 2,
                  onTap: _onItemTapped,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData inactiveIcon,
    required IconData activeIcon,
    required bool isActive,
    required Function(int) onTap,
  }) {
    final primaryColor = ref.watch(primaryColorProvider);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? primaryColor : Colors.grey,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              index == 0
                  ? 'Home'
                  : index == 1
                  ? 'History'
                  : 'Profile',
              style: TextStyle(
                color: isActive ? primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
