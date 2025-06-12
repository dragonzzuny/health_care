import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import feature screens
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/activity/presentation/activity_screen.dart';
import '../features/challenge/presentation/challenge_screen.dart';
import '../features/food/presentation/food_screen.dart';
import '../features/body/presentation/body_screen.dart';
import '../features/sleep/presentation/sleep_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/report/presentation/report_screen.dart';
import '../features/medication/presentation/medication_screen.dart';
import '../features/cosmetics/presentation/cosmetics_screen.dart';
import '../features/weather/presentation/weather_screen.dart';
import '../shared/widgets/main_navigation.dart';

// Route paths
class AppRoutes {
  static const String splash = '/';
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
  static const String profile = '/profile';
  static const String settings = '/settings';
}

// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
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

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if user is logged in
    // For now, navigate to login
    if (mounted) {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.health_and_safety,
                size: 64,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 32),
            
            // App Name
            Text(
              'SignCare',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // App Description
            Text(
              'AI 기반 개인 맞춤형 헬스케어',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 48),
            
            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

