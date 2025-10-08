import 'package:flutter/material.dart';

/// 그래프 노드 타입
enum NodeType {
  dataSource,    // 원본 데이터 (걸음 수, 칼로리 등)
  analysis,      // 중간 분석 단계
  conclusion,    // 최종 결론
}

/// 건강 데이터 카테고리
enum HealthCategory {
  activity,   // 활동
  nutrition,  // 영양
  sleep,      // 수면
  body,       // 신체측정
  overall,    // 종합
}

/// 그래프 노드 모델
class GraphNode {
  final String id;
  final String title;
  final String description;
  final NodeType type;
  final HealthCategory category;
  final dynamic value; // 실제 데이터 값
  final String? unit;  // 단위 (걸음, kcal, 시간 등)
  final double importance; // 중요도 (0.0 ~ 1.0)
  final Map<String, dynamic>? metadata;

  // 시각화 관련
  final Offset? position; // 그래프 상 위치
  final Color? color;     // 노드 색상

  const GraphNode({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    this.value,
    this.unit,
    this.importance = 0.5,
    this.metadata,
    this.position,
    this.color,
  });

  GraphNode copyWith({
    String? id,
    String? title,
    String? description,
    NodeType? type,
    HealthCategory? category,
    dynamic value,
    String? unit,
    double? importance,
    Map<String, dynamic>? metadata,
    Offset? position,
    Color? color,
  }) {
    return GraphNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      importance: importance ?? this.importance,
      metadata: metadata ?? this.metadata,
      position: position ?? this.position,
      color: color ?? this.color,
    );
  }

  /// 노드 타입에 따른 기본 색상
  Color get defaultColor {
    if (color != null) return color!;

    switch (type) {
      case NodeType.dataSource:
        return _getCategoryColor().withValues(alpha: 0.7);
      case NodeType.analysis:
        return _getCategoryColor().withValues(alpha: 0.5);
      case NodeType.conclusion:
        return _getCategoryColor();
    }
  }

  /// 카테고리별 색상
  Color _getCategoryColor() {
    switch (category) {
      case HealthCategory.activity:
        return Colors.blue;
      case HealthCategory.nutrition:
        return Colors.green;
      case HealthCategory.sleep:
        return Colors.indigo;
      case HealthCategory.body:
        return Colors.orange;
      case HealthCategory.overall:
        return Colors.purple;
    }
  }

  /// 노드 크기 (중요도 기반)
  double get nodeSize {
    switch (type) {
      case NodeType.dataSource:
        return 40 + (importance * 20);
      case NodeType.analysis:
        return 50 + (importance * 20);
      case NodeType.conclusion:
        return 60 + (importance * 20);
    }
  }

  /// 값을 문자열로 포맷
  String get formattedValue {
    if (value == null) return '';

    if (value is num) {
      if (value is double) {
        return '${value.toStringAsFixed(1)}${unit ?? ''}';
      }
      return '$value${unit ?? ''}';
    }

    return value.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'category': category.name,
      'value': value,
      'unit': unit,
      'importance': importance,
      'metadata': metadata,
      'position': position != null
          ? {'dx': position!.dx, 'dy': position!.dy}
          : null,
      'color': color?.toARGB32(),
    };
  }

  factory GraphNode.fromJson(Map<String, dynamic> json) {
    return GraphNode(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: NodeType.values.firstWhere((e) => e.name == json['type']),
      category: HealthCategory.values.firstWhere((e) => e.name == json['category']),
      value: json['value'],
      unit: json['unit'] as String?,
      importance: (json['importance'] as num?)?.toDouble() ?? 0.5,
      metadata: json['metadata'] as Map<String, dynamic>?,
      position: json['position'] != null
          ? Offset(
              (json['position']['dx'] as num).toDouble(),
              (json['position']['dy'] as num).toDouble(),
            )
          : null,
      color: json['color'] != null ? Color(json['color'] as int) : null,
    );
  }

  @override
  String toString() => 'GraphNode(id: $id, title: $title, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GraphNode && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
