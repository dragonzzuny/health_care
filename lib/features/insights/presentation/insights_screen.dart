import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/insight_reasoning.dart';
import '../models/graph_node.dart';
import '../models/graph_edge.dart';
import '../providers/insight_providers.dart';
import 'widgets/insight_graph_widget.dart';
import 'widgets/insight_detail_panel.dart';

/// 인사이트 메인 화면
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  GraphNode? _selectedNode;
  GraphEdge? _selectedEdge;

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
    final insights = ref.watch(weeklyHealthInsightsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('건강 인사이트'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: '활동'),
            Tab(text: '영양'),
            Tab(text: '수면'),
            Tab(text: '종합'),
          ],
        ),
      ),
      body: insights.when(
        data: (insightList) {
          if (insightList.isEmpty) {
            return _buildEmptyState();
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildInsightTab(
                insightList.where((i) => i.category == HealthCategory.activity).firstOrNull,
              ),
              _buildInsightTab(
                insightList.where((i) => i.category == HealthCategory.nutrition).firstOrNull,
              ),
              _buildInsightTab(
                insightList.where((i) => i.category == HealthCategory.sleep).firstOrNull,
              ),
              _buildInsightTab(
                insightList.where((i) => i.category == HealthCategory.overall).firstOrNull,
              ),
            ],
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  /// 인사이트 탭 화면 구성
  Widget _buildInsightTab(InsightReasoning? insight) {
    if (insight == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '이 카테고리의 인사이트가 아직 없습니다',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // 가로 모드: 그래프와 상세 정보를 나란히
    // 세로 모드: 그래프 위에 상세 정보를 스크롤
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      return Row(
        children: [
          // 그래프 영역 (왼쪽)
          Expanded(
            flex: 3,
            child: _buildGraphSection(insight),
          ),
          // 상세 정보 패널 (오른쪽)
          Expanded(
            flex: 2,
            child: InsightDetailPanel(
              reasoning: insight,
              selectedNode: _selectedNode,
              selectedEdge: _selectedEdge,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          // 그래프 영역 (위)
          Expanded(
            flex: 3,
            child: _buildGraphSection(insight),
          ),
          // 상세 정보 패널 (아래)
          Expanded(
            flex: 2,
            child: InsightDetailPanel(
              reasoning: insight,
              selectedNode: _selectedNode,
              selectedEdge: _selectedEdge,
            ),
          ),
        ],
      );
    }
  }

  /// 그래프 섹션
  Widget _buildGraphSection(InsightReasoning insight) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: InsightGraphWidget(
          reasoning: insight,
          selectedNodeId: _selectedNode?.id,
          selectedEdgeId: _selectedEdge?.id,
          onNodeTap: (node) {
            setState(() {
              _selectedNode = node;
              _selectedEdge = null; // 노드 선택 시 엣지 선택 해제
            });
          },
          onEdgeTap: (edge) {
            setState(() {
              _selectedEdge = edge;
              _selectedNode = null; // 엣지 선택 시 노드 선택 해제
            });
          },
        ),
      ),
    );
  }

  /// 빈 상태
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insights_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            '아직 인사이트가 없습니다',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 12),
          Text(
            '건강 데이터를 수집하면 AI 인사이트가 생성됩니다',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  /// 로딩 상태
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            'AI가 건강 데이터를 분석하고 있습니다...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '잠시만 기다려주세요',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  /// 에러 상태
  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
          const SizedBox(height: 24),
          Text(
            '인사이트를 불러올 수 없습니다',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red[700],
                ),
          ),
          const SizedBox(height: 12),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(weeklyHealthInsightsProvider);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
}
