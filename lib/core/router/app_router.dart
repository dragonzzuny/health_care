import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/app_providers.dart';

// Import feature screens
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/activity/presentation/activity_screen.dart';
import '../../features/challenge/presentation/challenge_screen.dart';
import '../../features/food/presentation/food_screen.dart';
import '../../features/body/presentation/body_screen.dart';
import '../../features/sleep/presentation/sleep_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/report/presentation/report_screen.dart';
import '../../features/medication/presentation/medication_screen.dart';
import '../../features/cosmetics/presentation/cosmetics_screen.dart';
import '../../features/weather/presentation/weather_screen.dart';
import '../../features/insights/presentation/insights_screen.dart';
import '../../shared/widgets/main_navigation.dart';
import '../../debug/database_debug_screen.dart';

// Route paths
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String activity = '/activity';
  static const String challenge = '/challenge';
  static const String food = '/food';
  static const String body = '/body';
  static const String sleep = '/sleep';
  static const String chat = '/chat';
  static const String report = '/report';
  static const String medication = '/medication';
  static const String cosmetics = '/cosmetics';
  static const String weather = '/weather';
  static const String insights = '/insights';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String databaseDebug = '/database-debug';
}

// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoggingIn = state.uri.toString() == AppRoutes.login;
      final isRegistering = state.uri.toString() == AppRoutes.register;

      if (!isLoggedIn && !isLoggingIn && !isRegistering) {
        return AppRoutes.login;
      }

      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Debug Routes
      GoRoute(
        path: AppRoutes.databaseDebug,
        builder: (context, state) => const DatabaseDebugScreen(),
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
            path: AppRoutes.activity,
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
            path: AppRoutes.challenge,
            builder: (context, state) => const ChallengeScreen(),
          ),
          GoRoute(
            path: AppRoutes.food,
            builder: (context, state) => const FoodScreen(),
          ),
          GoRoute(
            path: AppRoutes.body,
            builder: (context, state) => const BodyScreen(),
          ),
          GoRoute(
            path: AppRoutes.sleep,
            builder: (context, state) => const SleepScreen(),
          ),
          GoRoute(
            path: AppRoutes.chat,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: AppRoutes.report,
            builder: (context, state) => const ReportScreen(),
          ),
          GoRoute(
            path: AppRoutes.medication,
            builder: (context, state) => const MedicationScreen(),
          ),
          GoRoute(
            path: AppRoutes.cosmetics,
            builder: (context, state) => const CosmeticsScreen(),
          ),
          GoRoute(
            path: AppRoutes.weather,
            builder: (context, state) => const WeatherScreen(),
          ),
          GoRoute(
            path: AppRoutes.insights,
            builder: (context, state) => const InsightsScreen(),
          ),
        ],
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('오류')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '페이지를 찾을 수 없습니다',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('홈으로 돌아가기'),
            ),
          ],
        ),
      ),
    ),
  );
});
