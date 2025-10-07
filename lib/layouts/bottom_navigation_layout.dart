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

class _NavigationControllerState extends ConsumerState<NavigationController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(bottomNavIndexProvider);

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: initialIndex,
    );

    _pageController = PageController(initialPage: initialIndex);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final newIndex = _tabController.index;
      ref.read(bottomNavIndexProvider.notifier).state = newIndex;
      _pageController.jumpToPage(newIndex);
    }
  }

  void _onItemTapped(int index) {
    _tabController.animateTo(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    if (_tabController.index != index) {
      _tabController.index = index;
      ref.read(bottomNavIndexProvider.notifier).state = index;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final primaryColor = ref.watch(primaryColorProvider);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const ClampingScrollPhysics(),
        children: const [DashboardScreen(), HistoryScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: currentIndex,
        screenWidth: screenWidth,
        primaryColor: primaryColor,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _BottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final double screenWidth;
  final Color primaryColor;
  final Function(int) onItemTapped;

  const _BottomNavigationBar({
    required this.currentIndex,
    required this.screenWidth,
    required this.primaryColor,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                (screenWidth / 3) * currentIndex + (screenWidth / 3 - 40) / 2.8,
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
                    primaryColor.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.6),
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
              _BottomNavItem(
                index: 0,
                inactiveIcon: FontAwesomeIcons.house,
                activeIcon: FontAwesomeIcons.solidHouse,
                label: 'Home',
                isActive: currentIndex == 0,
                primaryColor: primaryColor,
                onTap: onItemTapped,
              ),
              _BottomNavItem(
                index: 1,
                inactiveIcon: FontAwesomeIcons.fileLines,
                activeIcon: FontAwesomeIcons.solidFileLines,
                label: 'History',
                isActive: currentIndex == 1,
                primaryColor: primaryColor,
                onTap: onItemTapped,
              ),
              _BottomNavItem(
                index: 2,
                inactiveIcon: FontAwesomeIcons.user,
                activeIcon: FontAwesomeIcons.solidUser,
                label: 'Profile',
                isActive: currentIndex == 2,
                primaryColor: primaryColor,
                onTap: onItemTapped,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends ConsumerWidget {
  final int index;
  final IconData inactiveIcon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final Color primaryColor;
  final Function(int) onTap;

  const _BottomNavItem({
    required this.index,
    required this.inactiveIcon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
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
              label,
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
