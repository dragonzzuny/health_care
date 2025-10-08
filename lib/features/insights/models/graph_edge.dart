import 'package:flutter/material.dart';

/// 엣지 타입
enum EdgeType {
  causal,      // 인과관계 (A가 B의 원인)
  correlation, // 상관관계 (A와 B가 관련)
  inference,   // 추론 (A로부터 B를 유추)
}

/// 그래프 엣지 모델 (노드 간 연결)
class GraphEdge {
  final String id;
  final String sourceNodeId;  // 출발 노드
  final String targetNodeId;  // 도착 노드
  final EdgeType type;
  final String label;         // 엣지 설명 (예: "영향을 줌", "관련됨")
  final double weight;        // 가중치/영향도 (0.0 ~ 1.0)
  final String? description;  // 상세 설명

  // 시각화 관련
  final Color? color;
  final double? strokeWidth;
  final bool showArrow;       // 화살표 표시 여부

  const GraphEdge({
    required this.id,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.type,
    required this.label,
    this.weight = 0.5,
    this.description,
    this.color,
    this.strokeWidth,
    this.showArrow = true,
  });

  GraphEdge copyWith({
    String? id,
    String? sourceNodeId,
    String? targetNodeId,
    EdgeType? type,
    String? label,
    double? weight,
    String? description,
    Color? color,
    double? strokeWidth,
    bool? showArrow,
  }) {
    return GraphEdge(
      id: id ?? this.id,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      type: type ?? this.type,
      label: label ?? this.label,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      showArrow: showArrow ?? this.showArrow,
    );
  }

  /// 엣지 타입에 따른 기본 색상
  Color get defaultColor {
    if (color != null) return color!;

    switch (type) {
      case EdgeType.causal:
        return Colors.red.withValues(alpha: 0.7);
      case EdgeType.correlation:
        return Colors.blue.withValues(alpha: 0.7);
      case EdgeType.inference:
        return Colors.green.withValues(alpha: 0.7);
    }
  }

  /// 가중치에 따른 선 굵기
  double get defaultStrokeWidth {
    if (strokeWidth != null) return strokeWidth!;
    return 1.0 + (weight * 3.0); // 1.0 ~ 4.0
  }

  /// 엣지 타입 아이콘
  IconData get typeIcon {
    switch (type) {
      case EdgeType.causal:
        return Icons.arrow_forward;
      case EdgeType.correlation:
        return Icons.compare_arrows;
      case EdgeType.inference:
        return Icons.lightbulb_outline;
    }
  }

  /// 엣지 타입 설명
  String get typeDescription {
    switch (type) {
      case EdgeType.causal:
        return '인과관계';
      case EdgeType.correlation:
        return '상관관계';
      case EdgeType.inference:
        return '추론';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceNodeId': sourceNodeId,
      'targetNodeId': targetNodeId,
      'type': type.name,
      'label': label,
      'weight': weight,
      'description': description,
      'color': color?.toARGB32(),
      'strokeWidth': strokeWidth,
      'showArrow': showArrow,
    };
  }

  factory GraphEdge.fromJson(Map<String, dynamic> json) {
    return GraphEdge(
      id: json['id'] as String,
      sourceNodeId: json['sourceNodeId'] as String,
      targetNodeId: json['targetNodeId'] as String,
      type: EdgeType.values.firstWhere((e) => e.name == json['type']),
      label: json['label'] as String,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.5,
      description: json['description'] as String?,
      color: json['color'] != null ? Color(json['color'] as int) : null,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
      showArrow: json['showArrow'] as bool? ?? true,
    );
  }

  @override
  String toString() =>
      'GraphEdge(id: $id, $sourceNodeId -> $targetNodeId, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GraphEdge && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
