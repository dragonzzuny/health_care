import 'graph_node.dart';
import 'graph_edge.dart';

/// 인사이트 우선순위
enum InsightPriority {
  high,    // 높음 (즉시 조치 필요)
  medium,  // 중간 (주의 필요)
  low,     // 낮음 (참고)
}

/// AI 추론 결과 모델
class InsightReasoning {
  final String id;
  final String title;               // 인사이트 제목
  final String summary;             // 요약
  final String detailedAnalysis;    // 상세 분석
  final List<String> recommendations; // 권장사항
  final InsightPriority priority;
  final HealthCategory category;

  // 추론 그래프
  final List<GraphNode> nodes;      // 모든 노드
  final List<GraphEdge> edges;      // 모든 엣지
  final String conclusionNodeId;    // 최종 결론 노드 ID

  // 신뢰도 및 메타데이터
  final double confidence;          // 신뢰도 (0.0 ~ 1.0)
  final DateTime generatedAt;
  final Map<String, dynamic>? metadata;

  const InsightReasoning({
    required this.id,
    required this.title,
    required this.summary,
    required this.detailedAnalysis,
    required this.recommendations,
    required this.priority,
    required this.category,
    required this.nodes,
    required this.edges,
    required this.conclusionNodeId,
    this.confidence = 0.8,
    required this.generatedAt,
    this.metadata,
  });

  /// 결론 노드 가져오기
  GraphNode? get conclusionNode {
    try {
      return nodes.firstWhere((node) => node.id == conclusionNodeId);
    } catch (_) {
      return null;
    }
  }

  /// 데이터 소스 노드들만 가져오기
  List<GraphNode> get dataSourceNodes {
    return nodes.where((node) => node.type == NodeType.dataSource).toList();
  }

  /// 분석 단계 노드들만 가져오기
  List<GraphNode> get analysisNodes {
    return nodes.where((node) => node.type == NodeType.analysis).toList();
  }

  /// 결론 노드들만 가져오기
  List<GraphNode> get conclusionNodes {
    return nodes.where((node) => node.type == NodeType.conclusion).toList();
  }

  /// 특정 노드의 입력 엣지 가져오기
  List<GraphEdge> getIncomingEdges(String nodeId) {
    return edges.where((edge) => edge.targetNodeId == nodeId).toList();
  }

  /// 특정 노드의 출력 엣지 가져오기
  List<GraphEdge> getOutgoingEdges(String nodeId) {
    return edges.where((edge) => edge.sourceNodeId == nodeId).toList();
  }

  /// 특정 노드의 부모 노드들 가져오기
  List<GraphNode> getParentNodes(String nodeId) {
    final incomingEdges = getIncomingEdges(nodeId);
    return nodes
        .where((node) => incomingEdges.any((edge) => edge.sourceNodeId == node.id))
        .toList();
  }

  /// 특정 노드의 자식 노드들 가져오기
  List<GraphNode> getChildNodes(String nodeId) {
    final outgoingEdges = getOutgoingEdges(nodeId);
    return nodes
        .where((node) => outgoingEdges.any((edge) => edge.targetNodeId == node.id))
        .toList();
  }

  /// 우선순위 색상
  String get priorityColor {
    switch (priority) {
      case InsightPriority.high:
        return 'red';
      case InsightPriority.medium:
        return 'orange';
      case InsightPriority.low:
        return 'green';
    }
  }

  /// 우선순위 텍스트
  String get priorityText {
    switch (priority) {
      case InsightPriority.high:
        return '높음';
      case InsightPriority.medium:
        return '중간';
      case InsightPriority.low:
        return '낮음';
    }
  }

  /// 신뢰도 텍스트
  String get confidenceText {
    if (confidence >= 0.9) return '매우 높음';
    if (confidence >= 0.75) return '높음';
    if (confidence >= 0.6) return '중간';
    if (confidence >= 0.4) return '낮음';
    return '매우 낮음';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'detailedAnalysis': detailedAnalysis,
      'recommendations': recommendations,
      'priority': priority.name,
      'category': category.name,
      'nodes': nodes.map((n) => n.toJson()).toList(),
      'edges': edges.map((e) => e.toJson()).toList(),
      'conclusionNodeId': conclusionNodeId,
      'confidence': confidence,
      'generatedAt': generatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory InsightReasoning.fromJson(Map<String, dynamic> json) {
    return InsightReasoning(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      detailedAnalysis: json['detailedAnalysis'] as String,
      recommendations: (json['recommendations'] as List).cast<String>(),
      priority: InsightPriority.values.firstWhere((e) => e.name == json['priority']),
      category: HealthCategory.values.firstWhere((e) => e.name == json['category']),
      nodes: (json['nodes'] as List)
          .map((n) => GraphNode.fromJson(n as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List)
          .map((e) => GraphEdge.fromJson(e as Map<String, dynamic>))
          .toList(),
      conclusionNodeId: json['conclusionNodeId'] as String,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.8,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  String toString() => 'InsightReasoning(id: $id, title: $title, priority: $priority)';
}
