import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

// 플랫폼별 import
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

// 테이블 import
import 'tables/foods_table.dart';
import 'tables/food_entries_table.dart';
import 'tables/recognition_history_table.dart';
import 'tables/user_preferences_table.dart';
import 'tables/activity_tables.dart';

// 이 파일은 build_runner로 생성됩니다
part 'app_database.g.dart';

@DriftDatabase(tables: [
  // 음식 관련 테이블
  Foods,
  FoodSynonyms,
  CommonPortions,
  
  // 식사 기록 테이블
  FoodEntries,
  FavoritePortions,
  DailyNutritionSummaries,
  
  // AI 인식 관련 테이블
  RecognitionHistories,
  RecognitionResults,
  RecognitionFeedbacks,
  
  // 사용자 설정 테이블
  UserPreferences,
  CustomFoods,
  UserFoodStatistics,
  
  // 활동 관련 테이블
  DailyActivities,
  WorkoutSessions,
  ActivityGoals,
  WeightRecords,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _insertInitialData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // 활동 관련 테이블 추가
          await m.createTable(dailyActivities);
          await m.createTable(workoutSessions);
          await m.createTable(activityGoals);
          await m.createTable(weightRecords);
        }
      },
      beforeOpen: (details) async {
        // WAL 모드 활성화 (성능 향상)
        await customStatement('PRAGMA journal_mode=WAL');
        // Foreign key constraints 활성화
        await customStatement('PRAGMA foreign_keys=ON');
      },
    );
  }

  /// 초기 데이터 삽입
  Future<void> _insertInitialData() async {
    // 기본 음식 데이터 삽입
    await batch((batch) {
      // 한국 음식 기본 데이터
      batch.insertAll(foods, [
        FoodsCompanion.insert(
          nameKo: '김치찌개',
          nameEn: const Value('Kimchi Stew'),
          category: '한식',
          subcategory: const Value('국물류'),
          kcalPer100g: const Value(19),
          carbsPer100g: const Value(2.4),
          proteinPer100g: const Value(1.6),
          fatPer100g: const Value(0.5),
          fiberPer100g: const Value(1.8),
          description: const Value('한국의 대표적인 찌개'),
          isVerified: const Value(true),
        ),
        FoodsCompanion.insert(
          nameKo: '현미밥',
          nameEn: const Value('Brown Rice'),
          category: '한식',
          subcategory: const Value('밥류'),
          kcalPer100g: const Value(112),
          carbsPer100g: const Value(23.0),
          proteinPer100g: const Value(2.6),
          fatPer100g: const Value(0.9),
          fiberPer100g: const Value(1.8),
          description: const Value('현미로 만든 건강한 밥'),
          isVerified: const Value(true),
        ),
        FoodsCompanion.insert(
          nameKo: '된장찌개',
          nameEn: const Value('Soybean Paste Stew'),
          category: '한식',
          subcategory: const Value('국물류'),
          kcalPer100g: const Value(25),
          carbsPer100g: const Value(3.2),
          proteinPer100g: const Value(2.1),
          fatPer100g: const Value(0.8),
          fiberPer100g: const Value(1.2),
          description: const Value('된장으로 끓인 전통 찌개'),
          isVerified: const Value(true),
        ),
        FoodsCompanion.insert(
          nameKo: '비빔밥',
          nameEn: const Value('Bibimbap'),
          category: '한식',
          subcategory: const Value('밥류'),
          kcalPer100g: const Value(169),
          carbsPer100g: const Value(26.0),
          proteinPer100g: const Value(5.6),
          fatPer100g: const Value(4.5),
          fiberPer100g: const Value(2.8),
          description: const Value('다양한 나물과 밥을 비벼 먹는 음식'),
          isVerified: const Value(true),
        ),
        FoodsCompanion.insert(
          nameKo: '사과',
          nameEn: const Value('Apple'),
          category: '과일',
          kcalPer100g: const Value(52),
          carbsPer100g: const Value(14.0),
          proteinPer100g: const Value(0.3),
          fatPer100g: const Value(0.2),
          fiberPer100g: const Value(2.4),
          sugarPer100g: const Value(10.4),
          description: const Value('신선한 사과'),
          isVerified: const Value(true),
        ),
      ]);
    });

    // 동의어 삽입
    await batch((batch) {
      batch.insertAll(foodSynonyms, [
        FoodSynonymsCompanion.insert(
          foodId: 1, // 김치찌개
          synonym: '김치국',
          type: 'alias',
        ),
        FoodSynonymsCompanion.insert(
          foodId: 2, // 현미밥
          synonym: '건강밥',
          type: 'alias',
        ),
        FoodSynonymsCompanion.insert(
          foodId: 2,
          synonym: '갈색쌀밥',
          type: 'alias',
        ),
        FoodSynonymsCompanion.insert(
          foodId: 5, // 사과
          synonym: 'apple',
          type: 'english',
        ),
      ]);
    });

    // 일반적인 포션 정보 삽입
    await batch((batch) {
      batch.insertAll(commonPortions, [
        CommonPortionsCompanion.insert(
          foodId: 1, // 김치찌개
          portionName: '한 그릇',
          gramAmount: 200,
          description: const Value('일반적인 찌개 그릇'),
          isDefault: const Value(true),
        ),
        CommonPortionsCompanion.insert(
          foodId: 2, // 현미밥
          portionName: '한 공기',
          gramAmount: 150,
          description: const Value('일반적인 밥공기'),
          isDefault: const Value(true),
        ),
        CommonPortionsCompanion.insert(
          foodId: 2,
          portionName: '반 공기',
          gramAmount: 75,
          description: const Value('작은 분량'),
        ),
        CommonPortionsCompanion.insert(
          foodId: 5, // 사과
          portionName: '1개',
          gramAmount: 200,
          description: const Value('중간 크기 사과 1개'),
          isDefault: const Value(true),
        ),
      ]);
    });
  }

  /// 트랜잭션을 위한 helper 메서드들
  Future<T> runInTransaction<T>(Future<T> Function() action) async {
    return await transaction(() async {
      return await action();
    });
  }

  /// 데이터베이스 연결 상태 확인
  Future<bool> isDatabaseHealthy() async {
    try {
      await customSelect('SELECT 1').get();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 데이터베이스 백업
  Future<String> backupDatabase() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final backupPath = p.join(dbFolder.path, 'signcare_backup_${DateTime.now().millisecondsSinceEpoch}.db');
    
    await customStatement('VACUUM INTO ?', [backupPath]);
    return backupPath;
  }

  /// 데이터베이스 통계 정보
  Future<Map<String, int>> getDatabaseStats() async {
    final stats = <String, int>{};
    
    final tables = [
      'foods', 'food_entries', 'recognition_histories', 'recognition_results',
      'user_preferences', 'custom_foods', 'favorite_portions'
    ];
    
    for (final table in tables) {
      final result = await customSelect('SELECT COUNT(*) as count FROM $table').getSingle();
      stats[table] = result.data['count'] as int;
    }
    
    return stats;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return await _createDatabase();
  });
}

Future<QueryExecutor> _createDatabase() async {
  // Native database 사용 (모바일/데스크톱)
  return await _createNativeDatabase();
}

Future<QueryExecutor> _createNativeDatabase() async {
  try {
    if (Platform.isWindows) {
      // Windows에서는 Documents 폴더 사용
      final dbFolder = Directory(p.join(Platform.environment['USERPROFILE'] ?? '.', 'Documents'));

      // 디렉토리가 존재하지 않으면 생성
      if (!dbFolder.existsSync()) {
        dbFolder.createSync(recursive: true);
      }

      final file = File(p.join(dbFolder.path, 'signcare_app.db'));
      return NativeDatabase.createInBackground(file, logStatements: true);
    } else {
      // 모바일 플랫폼에서는 getApplicationDocumentsDirectory 사용
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final file = File(p.join(documentsDirectory.path, 'signcare_app.db'));
      return NativeDatabase.createInBackground(file, logStatements: true);
    }
  } catch (e) {
    // 폴백으로 현재 디렉토리 사용
    final file = File('signcare_app.db');
    return NativeDatabase.createInBackground(file, logStatements: true);
  }
}