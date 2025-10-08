import 'package:flutter/material.dart';
import '../../models/graph_node.dart';
import '../../models/graph_edge.dart';
import '../../models/insight_reasoning.dart';

/// 선택된 노드/엣지의 상세 정보를 표시하는 패널
class InsightDetailPanel extends StatelessWidget {
  final InsightReasoning reasoning;
  final GraphNode? selectedNode;
  final GraphEdge? selectedEdge;

  const InsightDetailPanel({
    super.key,
    required this.reasoning,
    this.selectedNode,
    this.selectedEdge,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedNode != null) {
      return _buildNodeDetail(context, selectedNode!);
    } else if (selectedEdge != null) {
      return _buildEdgeDetail(context, selectedEdge!);
    } else {
      return _buildOverview(context);
    }
  }

  /// 노드 상세 정보
  Widget _buildNodeDetail(BuildContext context, GraphNode node) {
    // 이 노드의 입력/출력 엣지 가져오기
    final incomingEdges = reasoning.getIncomingEdges(node.id);
    final outgoingEdges = reasoning.getOutgoingEdges(node.id);
    final parentNodes = reasoning.getParentNodes(node.id);
    final childNodes = reasoning.getChildNodes(node.id);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 노드 타입 배지
              Row(
                children: [
                  _buildTypeBadge(node.type, node.category),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      node.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 값 (있는 경우)
              if (node.value != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: node.defaultColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        node.formattedValue,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: node.defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 설명
              Text(
                '설명',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                node.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              // 참고한 데이터 (부모 노드들)
              if (parentNodes.isNotEmpty) ...[
                Text(
                  '참고한 데이터',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ...parentNodes.map((parent) {
                  final edge = incomingEdges.firstWhere(
                    (e) => e.sourceNodeId == parent.id,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildRelationshipItem(
                      context,
                      parent,
                      edge,
                      isIncoming: true,
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],

              // 영향을 주는 데이터 (자식 노드들)
              if (childNodes.isNotEmpty) ...[
                Text(
                  '영향을 주는 항목',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ...childNodes.map((child) {
                  final edge = outgoingEdges.firstWhere(
                    (e) => e.targetNodeId == child.id,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildRelationshipItem(
                      context,
                      child,
                      edge,
                      isIncoming: false,
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],

              // 중요도
              Row(
                children: [
                  Text(
                    '중요도: ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: node.importance,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(node.defaultColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(node.importance * 100).toInt()}%'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 엣지 상세 정보
  Widget _buildEdgeDetail(BuildContext context, GraphEdge edge) {
    final sourceNode = reasoning.nodes.where((n) => n.id == edge.sourceNodeId).firstOrNull;
    final targetNode = reasoning.nodes.where((n) => n.id == edge.targetNodeId).firstOrNull;

    if (sourceNode == null || targetNode == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 엣지 타입 배지
              Row(
                children: [
                  Icon(edge.typeIcon, color: edge.defaultColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    edge.typeDescription,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: edge.defaultColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 관계 표시
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildNodeSummary(context, sourceNode),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.arrow_downward,
                      color: edge.defaultColor,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        edge.label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: edge.defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: edge.defaultColor,
                      size: 24,
                    ),
                    const SizedBox(height: 12),
                    _buildNodeSummary(context, targetNode),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 설명
              if (edge.description != null) ...[
                Text(
                  '설명',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  edge.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
              ],

              // 영향도
              Row(
                children: [
                  Text(
                    '영향도: ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: edge.weight,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(edge.defaultColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(edge.weight * 100).toInt()}%'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 전체 개요
  Widget _buildOverview(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 인사이트 제목
              Row(
                children: [
                  _buildPriorityBadge(reasoning.priority),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      reasoning.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 요약
              Text(
                reasoning.summary,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),

              // 상세 분석
              Text(
                '상세 분석',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                reasoning.detailedAnalysis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              // 권장사항
              if (reasoning.recommendations.isNotEmpty) ...[
                Text(
                  '권장사항',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ...reasoning.recommendations.map((rec) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle, size: 20, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              rec,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
              ],

              // 그래프 통계
              _buildGraphStats(context),

              const SizedBox(height: 16),

              // 안내 문구
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '노드나 연결선을 클릭하면 상세 정보를 확인할 수 있습니다',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue[900],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraphStats(BuildContext context) {
    final dataSourceCount = reasoning.dataSourceNodes.length;
    final analysisCount = reasoning.analysisNodes.length;
    final conclusionCount = reasoning.conclusionNodes.length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, '데이터', dataSourceCount, Icons.data_object),
          _buildStatItem(context, '분석', analysisCount, Icons.analytics),
          _buildStatItem(context, '결론', conclusionCount, Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, int count, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.grey[700]),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildRelationshipItem(
    BuildContext context,
    GraphNode node,
    GraphEdge edge,
    {required bool isIncoming}
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: node.defaultColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: node.defaultColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            node.type == NodeType.dataSource
                ? Icons.data_object
                : node.type == NodeType.analysis
                    ? Icons.analytics
                    : Icons.check_circle,
            color: node.defaultColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  edge.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Icon(
            isIncoming ? Icons.arrow_forward : Icons.arrow_forward,
            color: edge.defaultColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildNodeSummary(BuildContext context, GraphNode node) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: node.defaultColor),
      ),
      child: Row(
        children: [
          Icon(
            node.type == NodeType.dataSource
                ? Icons.data_object
                : node.type == NodeType.analysis
                    ? Icons.analytics
                    : Icons.check_circle,
            color: node.defaultColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (node.value != null)
                  Text(
                    node.formattedValue,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: node.defaultColor,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(NodeType type, HealthCategory category) {
    String label;
    IconData icon;
    Color color;

    switch (type) {
      case NodeType.dataSource:
        label = '데이터';
        icon = Icons.data_object;
        color = Colors.blue;
        break;
      case NodeType.analysis:
        label = '분석';
        icon = Icons.analytics;
        color = Colors.orange;
        break;
      case NodeType.conclusion:
        label = '결론';
        icon = Icons.check_circle;
        color = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(InsightPriority priority) {
    Color color;
    IconData icon;

    switch (priority) {
      case InsightPriority.high:
        color = Colors.red;
        icon = Icons.priority_high;
        break;
      case InsightPriority.medium:
        color = Colors.orange;
        icon = Icons.warning;
        break;
      case InsightPriority.low:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '우선순위: ${priority.name}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
