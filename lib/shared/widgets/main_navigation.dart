import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../providers/developer_mode_provider.dart';

class MainNavigation extends ConsumerWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index) => _onItemTapped(index, context),
          backgroundColor: Colors.white,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: 'Pretendard',
          ),
          elevation: 0,
          items: [
            _buildNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: '홈',
            ),
            _buildNavItem(
              icon: Icons.restaurant_outlined,
              activeIcon: Icons.restaurant,
              label: '식단',
            ),
            _buildNavItem(
              icon: Icons.fitness_center_outlined,
              activeIcon: Icons.fitness_center,
              label: '운동',
            ),
            _buildNavItem(
              icon: Icons.bedtime_outlined,
              activeIcon: Icons.bedtime,
              label: '수면',
            ),
            _buildNavItem(
              icon: Icons.chat_bubble_outline,
              activeIcon: Icons.chat_bubble,
              label: '대화', // Renamed from 상담
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context, ref),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    final isDeveloperMode = ref.watch(developerModeProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '사용자님',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.assessment_outlined,
            title: '건강 리포트',
            onTap: () => context.go(AppRoutes.report),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.medication_outlined,
            title: '약물 관리',
            onTap: () => context.go(AppRoutes.medication),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.face_retouching_natural_outlined,
            title: '화장품 분석',
            onTap: () => context.go(AppRoutes.cosmetics),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.wb_sunny_outlined,
            title: '날씨 & 대기질',
            onTap: () => context.go(AppRoutes.weather),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.monitor_weight_outlined,
            title: '신체 측정',
            onTap: () => context.go(AppRoutes.body),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.settings_outlined,
            title: '설정',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('설정 기능 준비 중입니다')),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: '로그아웃',
            onTap: () => context.go(AppRoutes.login),
          ),
          if (isDeveloperMode) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '개발자 옵션',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.storage,
              title: '데이터베이스 확인',
              onTap: () => context.go(AppRoutes.databaseDebug),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[900],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.home) ||
        location.startsWith(AppRoutes.activity)) return 0;
    if (location.startsWith(AppRoutes.food)) return 1;
    if (location.startsWith(AppRoutes.challenge))
      return 2; // Exercise mapped to challenge/fitness area? Wait.
    // The previous code mapped index 2 to ChallengeScreen. Label was "운동" (Exercise).
    // Usually 'fitness_center' implies exercise. Let's keep it consistent with previous logic.
    if (location.startsWith(AppRoutes.sleep)) return 3;
    if (location.startsWith(AppRoutes.chat)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.food);
        break;
      case 2:
        context.go(AppRoutes
            .challenge); // Assuming 'Exercise' tab leads here as per previous code
        break;
      case 3:
        context.go(AppRoutes.sleep);
        break;
      case 4:
        context.go(AppRoutes.chat);
        break;
    }
  }
}
