import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../core/database/app_database.dart';
import '../shared/providers/database_providers.dart';
import '../core/mock/mock_food_data.dart';

class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 뷰어'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: '개요'),
            Tab(icon: Icon(Icons.table_chart), text: '데이터'),
            Tab(icon: Icon(Icons.schema), text: '스키마'),
            Tab(icon: Icon(Icons.settings), text: '관리'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OverviewTab(),
          _TableDataTab(),
          _SchemaTab(),
          _ManagementTab(),
        ],
      ),
    );
  }
}

// ============================================================================
// 1. 개요 탭
// ============================================================================
class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(databaseStatsProvider);
        ref.invalidate(databaseHealthProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatabaseInfoSection(context, ref),
            const SizedBox(height: 16),
            _buildDatabaseStatsSection(context, ref),
            const SizedBox(height: 16),
            _buildQuickStatsSection(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildDatabaseInfoSection(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getDatabaseInfo(ref),
      builder: (buildContext, snapshot) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      'DB 파일 정보',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (snapshot.hasData) ...[
                  _buildInfoRow(context, '파일명', snapshot.data!['fileName'] ?? 'N/A'),
                  _buildInfoRow(context, '경로', snapshot.data!['path'] ?? 'N/A', monospace: true),
                  _buildInfoRow(context, '크기', snapshot.data!['size'] ?? 'N/A'),
                  _buildInfoRow(context, '스키마 버전', snapshot.data!['schemaVersion']?.toString() ?? 'N/A'),
                  _buildInfoRow(context, '상태', snapshot.data!['isHealthy'] == true ? '정상 ✓' : '오류 ✗'),
                ] else if (snapshot.hasError)
                  Text('오류: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDatabaseStatsSection(BuildContext context, WidgetRef ref) {
    final dbStats = ref.watch(databaseStatsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.table_rows, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '테이블별 레코드 수',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            dbStats.when(
              data: (stats) {
                final sortedEntries = stats.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return Column(
                  children: sortedEntries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${entry.value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('오류: $e', style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.speed, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  '빠른 통계',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FutureBuilder<Map<String, int>>(
              future: _getQuickStats(ref),
              builder: (buildContext, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildStatChip(context, '총 음식', snapshot.data!['totalFoods'] ?? 0, Colors.blue),
                      _buildStatChip(context, '식사 기록', snapshot.data!['totalEntries'] ?? 0, Colors.green),
                      _buildStatChip(context, 'AI 인식', snapshot.data!['totalRecognitions'] ?? 0, Colors.purple),
                      _buildStatChip(context, '활동 기록', snapshot.data!['totalActivities'] ?? 0, Colors.orange),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool monospace = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('클립보드에 복사되었습니다'), duration: Duration(seconds: 1)),
                );
              },
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: monospace ? 'monospace' : null,
                  fontSize: monospace ? 12 : 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String label, int value, Color color) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: color,
        child: Text(
          value.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
      label: Text(label),
    );
  }

  Future<Map<String, dynamic>> _getDatabaseInfo(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'signcare_app.db'));

    final isHealthy = await db.isDatabaseHealthy();
    final size = file.existsSync() ? file.lengthSync() : 0;

    return {
      'fileName': 'signcare_app.db',
      'path': file.path,
      'size': '${(size / 1024).toStringAsFixed(2)} KB',
      'schemaVersion': db.schemaVersion,
      'isHealthy': isHealthy,
    };
  }

  Future<Map<String, int>> _getQuickStats(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);

    final foodsCount = await (db.select(db.foods)).get().then((rows) => rows.length);
    final entriesCount = await (db.select(db.foodEntries)).get().then((rows) => rows.length);
    final recognitionsCount = await (db.select(db.recognitionHistories)).get().then((rows) => rows.length);
    final activitiesCount = await (db.select(db.dailyActivities)).get().then((rows) => rows.length);

    return {
      'totalFoods': foodsCount,
      'totalEntries': entriesCount,
      'totalRecognitions': recognitionsCount,
      'totalActivities': activitiesCount,
    };
  }
}

// ============================================================================
// 2. 테이블 데이터 탭
// ============================================================================
class _TableDataTab extends ConsumerStatefulWidget {
  const _TableDataTab();

  @override
  ConsumerState<_TableDataTab> createState() => _TableDataTabState();
}

class _TableDataTabState extends ConsumerState<_TableDataTab> {
  String _selectedTable = 'foods';

  final List<String> _tables = [
    'foods',
    'food_synonyms',
    'common_portions',
    'food_entries',
    'favorite_portions',
    'daily_nutrition_summaries',
    'recognition_histories',
    'recognition_results',
    'recognition_feedbacks',
    'user_preferences',
    'custom_foods',
    'user_food_statistics',
    'daily_activities',
    'workout_sessions',
    'activity_goals',
    'weight_records',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              const Text('테이블 선택:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedTable,
                  isExpanded: true,
                  items: _tables.map((table) => DropdownMenuItem(
                    value: table,
                    child: Text(table, style: const TextStyle(fontFamily: 'monospace')),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedTable = value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            key: ValueKey(_selectedTable),
            future: _getTableData(_selectedTable),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('오류: ${snapshot.error}'),
                    ],
                  ),
                );
              }

              final data = snapshot.data ?? [];

              if (data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 48, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('데이터가 없습니다'),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final row = data[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      title: Text(
                        '레코드 #${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${row.length} 컬럼',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: row.entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        entry.key,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'monospace',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SelectableText(
                                        entry.value?.toString() ?? 'NULL',
                                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _getTableData(String tableName) async {
    final db = ref.read(appDatabaseProvider);

    try {
      final result = await db.customSelect('SELECT * FROM $tableName LIMIT 100').get();
      return result.map((row) => row.data).toList();
    } catch (e) {
      throw Exception('테이블 조회 실패: $e');
    }
  }
}

// ============================================================================
// 3. 스키마 탭
// ============================================================================
class _SchemaTab extends ConsumerWidget {
  const _SchemaTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getTableSchemas(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류: ${snapshot.error}'));
        }

        final schemas = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: schemas.length,
          itemBuilder: (context, index) {
            final schema = schemas[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                title: Text(
                  schema['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                ),
                subtitle: Text('${schema['columns'].length} 컬럼'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CREATE TABLE SQL:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SelectableText(
                            schema['sql'] as String,
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _getTableSchemas(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);

    final result = await db.customSelect(
      "SELECT name, sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    ).get();

    return result.map((row) {
      return {
        'name': row.data['name'],
        'sql': row.data['sql'],
        'columns': [], // SQL 파싱으로 컬럼 정보 추출 가능
      };
    }).toList();
  }
}

// ============================================================================
// 4. 관리 탭
// ============================================================================
class _ManagementTab extends ConsumerWidget {
  const _ManagementTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBackupSection(context, ref),
        const SizedBox(height: 16),
        _buildSampleDataSection(context, ref),
        const SizedBox(height: 16),
        _buildDangerZoneSection(context, ref),
      ],
    );
  }

  Widget _buildBackupSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.backup, color: Colors.blue),
                SizedBox(width: 8),
                Text('백업 & 복원', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('데이터베이스를 백업하거나 복원할 수 있습니다.'),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final db = ref.read(appDatabaseProvider);
                  final backupPath = await db.backupDatabase();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('백업 완료: $backupPath')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('백업 실패: $e'), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('데이터베이스 백업'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleDataSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.data_object, color: Colors.green),
                SizedBox(width: 8),
                Text('샘플 데이터', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('테스트용 샘플 데이터를 추가할 수 있습니다.'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _addSampleFoodEntries(context, ref),
                  icon: const Icon(Icons.restaurant),
                  label: const Text('식사 기록 추가'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _addSampleActivities(context, ref),
                  icon: const Icon(Icons.directions_run),
                  label: const Text('활동 기록 추가'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerZoneSection(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text('위험 구역', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('주의: 아래 작업은 되돌릴 수 없습니다.'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _showClearDataDialog(context, ref),
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              label: const Text('모든 데이터 삭제', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addSampleFoodEntries(BuildContext context, WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);

    try {
      final now = DateTime.now();
      await db.into(db.foodEntries).insert(FoodEntriesCompanion.insert(
        userId: MockFoodData.userId,
        foodId: 1,
        mealType: 'breakfast',
        timestamp: now.subtract(const Duration(hours: 2)),
        portionGrams: 200,
        totalCalories: 150,
        totalCarbs: 30,
        totalProtein: 5,
        totalFat: 2,
        totalFiber: 3,
      ));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('샘플 식사 기록이 추가되었습니다')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('추가 실패: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _addSampleActivities(BuildContext context, WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);

    try {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);

      await db.into(db.dailyActivities).insert(
        DailyActivitiesCompanion.insert(
          userId: MockFoodData.userId,
          date: todayDate,
          steps: const Value(8500),
          caloriesBurned: const Value(350),
          activeMinutes: const Value(45),
        ),
        mode: InsertMode.insertOrReplace,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('샘플 활동 기록이 추가되었습니다')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('추가 실패: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ 경고'),
        content: const Text('정말로 모든 데이터를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('데이터 삭제 기능은 아직 구현되지 않았습니다')),
              );
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
