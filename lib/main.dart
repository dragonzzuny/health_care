import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/services/data_initializer.dart';
import 'shared/providers/database_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

/// 데이터 초기화 프로바이더
final dataInitializationProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final initializer = DataInitializer(db);
  
  try {
    // 이미 초기화되었는지 확인
    final isInitialized = await initializer.isDataInitialized();
    
    if (!isInitialized) {
      // Mock 데이터 초기화
      await initializer.initializeAllMockData();
      print('✅ 앱 시작 시 데이터 초기화 완료');
    } else {
      print('✅ 데이터가 이미 초기화되어 있습니다');
    }
    
    return true;
  } catch (e) {
    print('❌ 데이터 초기화 실패: $e');
    return false;
  }
});

/// Root widget that provides the [ProviderScope] for the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: HealthcareApp(),
    );
  }
}

class HealthcareApp extends ConsumerWidget {
  const HealthcareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final dataInitialization = ref.watch(dataInitializationProvider);

    return MaterialApp.router(
      title: 'SignCare',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return dataInitialization.when(
          data: (success) => child ?? const SizedBox(),
          loading: () => const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'SignCare를 준비하고 있습니다...',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '건강 데이터를 초기화하는 중입니다.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
          error: (error, stack) => MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'SignCare를 시작할 수 없습니다',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '오류: $error',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // 데이터 초기화 재시도
                        ref.invalidate(dataInitializationProvider);
                      },
                      child: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

