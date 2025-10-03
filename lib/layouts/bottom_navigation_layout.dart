import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/screens/dashboard/dashboard_screen.dart';
import 'package:immobile_bctech_app/screens/history/history_screen.dart';
import 'package:immobile_bctech_app/screens/profile/profile_screen.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class NavigationController extends ConsumerWidget {
  const NavigationController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final pages = [DashboardScreen(), HistoryScreen(), ProfileScreen()];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.09),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              ref,
              index: 0,
              inactiveIcon: FontAwesomeIcons.house,
              activeIcon: FontAwesomeIcons.solidHouse,
              isActive: currentIndex == 0,
            ),
            _buildNavItem(
              context,
              ref,
              index: 1,
              inactiveIcon: FontAwesomeIcons.fileLines,
              activeIcon: FontAwesomeIcons.solidFileLines,
              isActive: currentIndex == 1,
            ),
            _buildNavItem(
              context,
              ref,
              index: 2,
              inactiveIcon: FontAwesomeIcons.user,
              activeIcon: FontAwesomeIcons.solidUser,
              isActive: currentIndex == 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required IconData inactiveIcon,
    required IconData activeIcon,
    required bool isActive,
  }) {
    Color primaryColor = ref.watch(primaryColorProvider);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: 1.0, end: isActive ? 1.2 : 1.0),
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isActive
                      ? primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  isActive ? activeIcon : inactiveIcon,
                  color: isActive ? primaryColor : Colors.grey,
                  size: isActive ? 22 : 22,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              index == 0
                  ? 'Home'
                  : index == 1
                  ? 'History'
                  : 'Profile',
              style: TextStyle(
                color: isActive ? primaryColor : Colors.grey,
                fontSize: isActive ? 12 : 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 6 : 0,
              height: isActive ? 6 : 0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
