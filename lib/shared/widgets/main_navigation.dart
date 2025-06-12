import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: '식단',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: '운동',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: '수면',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '상담',
          ),
        ],
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
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
                Text(
                  '사용자님',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('건강 리포트'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.report);
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('약물 관리'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.medication);
            },
          ),
          ListTile(
            leading: const Icon(Icons.face_retouching_natural),
            title: const Text('화장품 분석'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.cosmetics);
            },
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny),
            title: const Text('날씨 & 대기질'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.weather);
            },
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: const Text('신체 측정'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.body);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('설정 기능 준비 중입니다')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('로그아웃'),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    switch (location) {
      case AppRoutes.home:
      case AppRoutes.activity:
        return 0;
      case AppRoutes.food:
        return 1;
      case AppRoutes.challenge:
        return 2;
      case AppRoutes.sleep:
        return 3;
      case AppRoutes.chat:
        return 4;
      default:
        return 0;
    }
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
        context.go(AppRoutes.challenge);
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

