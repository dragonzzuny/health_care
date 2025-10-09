import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/graph_node.dart';
import '../../models/graph_edge.dart';
import '../../models/insight_reasoning.dart';

/// 인사이트 그래프 시각화 위젯
class InsightGraphWidget extends StatefulWidget {
  final InsightReasoning reasoning;
  final Function(GraphNode?)? onNodeTap;
  final Function(GraphEdge?)? onEdgeTap;
  final String? selectedNodeId;
  final String? selectedEdgeId;

  const InsightGraphWidget({
    super.key,
    required this.reasoning,
    this.onNodeTap,
    this.onEdgeTap,
    this.selectedNodeId,
    this.selectedEdgeId,
  });

  @override
  State<InsightGraphWidget> createState() => _InsightGraphWidgetState();
}

class _InsightGraphWidgetState extends State<InsightGraphWidget> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 3.0,
      boundaryMargin: const EdgeInsets.all(100),
      child: CustomPaint(
        size: const Size(600, 600),
        painter: InsightGraphPainter(
          nodes: widget.reasoning.nodes,
          edges: widget.reasoning.edges,
          selectedNodeId: widget.selectedNodeId,
          selectedEdgeId: widget.selectedEdgeId,
        ),
        child: GestureDetector(
          onTapUp: (details) => _handleTap(details.localPosition),
          behavior: HitTestBehavior.translucent,
          child: const SizedBox(
            width: 600,
            height: 600,
          ),
        ),
      ),
    );
  }

  void _handleTap(Offset position) {
    // 노드 클릭 감지
    for (final node in widget.reasoning.nodes) {
      if (node.position == null) continue;

      final distance = (position - node.position!).distance;
      if (distance <= node.nodeSize) {
        widget.onNodeTap?.call(node);
        return;
      }
    }

    // 엣지 클릭 감지 (선에 가까운지 체크)
    for (final edge in widget.reasoning.edges) {
      final sourceNode = widget.reasoning.nodes.where((n) => n.id == edge.sourceNodeId).firstOrNull;
      final targetNode = widget.reasoning.nodes.where((n) => n.id == edge.targetNodeId).firstOrNull;

      if (sourceNode?.position == null || targetNode?.position == null) continue;

      final distance = _distanceToLineSegment(
        position,
        sourceNode!.position!,
        targetNode!.position!,
      );

      if (distance <= 10) {
        widget.onEdgeTap?.call(edge);
        return;
      }
    }

    // 아무것도 클릭하지 않았으면 선택 해제
    widget.onNodeTap?.call(null);
  }

  double _distanceToLineSegment(Offset point, Offset lineStart, Offset lineEnd) {
    final lengthSquared = (lineEnd - lineStart).distanceSquared;
    if (lengthSquared == 0) return (point - lineStart).distance;

    final t = math.max(0.0, math.min(1.0, (point - lineStart).dot(lineEnd - lineStart) / lengthSquared)).toDouble();
    final projection = lineStart + (lineEnd - lineStart) * t;

    return (point - projection).distance;
  }
}

/// 그래프 페인터
class InsightGraphPainter extends CustomPainter {
  final List<GraphNode> nodes;
  final List<GraphEdge> edges;
  final String? selectedNodeId;
  final String? selectedEdgeId;

  InsightGraphPainter({
    required this.nodes,
    required this.edges,
    this.selectedNodeId,
    this.selectedEdgeId,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. 엣지 그리기 (노드 뒤에)
    for (final edge in edges) {
      _drawEdge(canvas, edge);
    }

    // 2. 노드 그리기
    for (final node in nodes) {
      if (node.position != null) {
        _drawNode(canvas, node);
      }
    }
  }

  void _drawEdge(Canvas canvas, GraphEdge edge) {
    final sourceNode = nodes.where((n) => n.id == edge.sourceNodeId).firstOrNull;
    final targetNode = nodes.where((n) => n.id == edge.targetNodeId).firstOrNull;

    if (sourceNode?.position == null || targetNode?.position == null) return;

    final start = sourceNode!.position!;
    final end = targetNode!.position!;

    final isSelected = edge.id == selectedEdgeId;
    final color = isSelected
        ? edge.defaultColor.withValues(alpha: 1.0)
        : edge.defaultColor;

    final paint = Paint()
      ..color = color
      ..strokeWidth = isSelected ? edge.defaultStrokeWidth + 1 : edge.defaultStrokeWidth
      ..style = PaintingStyle.stroke;

    // 화살표 그리기
    if (edge.showArrow) {
      _drawArrow(canvas, start, end, paint, targetNode.nodeSize);
    } else {
      canvas.drawLine(start, end, paint);
    }

    // 엣지 레이블 그리기
    if (isSelected) {
      final midPoint = Offset(
        (start.dx + end.dx) / 2,
        (start.dy + end.dy) / 2,
      );
      _drawEdgeLabel(canvas, edge.label, midPoint);
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint, double targetNodeSize) {
    // 화살표가 노드에 닿지 않도록 끝점 조정
    final direction = (end - start);
    final distance = direction.distance;
    final unitDirection = direction / distance;
    final adjustedEnd = end - unitDirection * (targetNodeSize + 5);

    // 선 그리기
    canvas.drawLine(start, adjustedEnd, paint);

    // 화살촉 그리기
    const arrowSize = 12.0;
    final angle = math.atan2(direction.dy, direction.dx);

    final arrowPoint1 = adjustedEnd + Offset(
      -arrowSize * math.cos(angle - math.pi / 6),
      -arrowSize * math.sin(angle - math.pi / 6),
    );

    final arrowPoint2 = adjustedEnd + Offset(
      -arrowSize * math.cos(angle + math.pi / 6),
      -arrowSize * math.sin(angle + math.pi / 6),
    );

    final path = Path()
      ..moveTo(adjustedEnd.dx, adjustedEnd.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();

    canvas.drawPath(path, Paint()..color = paint.color..style = PaintingStyle.fill);
  }

  void _drawEdgeLabel(Canvas canvas, String label, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          backgroundColor: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawNode(Canvas canvas, GraphNode node) {
    final position = node.position!;
    final isSelected = node.id == selectedNodeId;
    final size = node.nodeSize;

    // 선택된 노드 배경 (glow 효과)
    if (isSelected) {
      final glowPaint = Paint()
        ..color = node.defaultColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(position, size + 8, glowPaint);
    }

    // 노드 배경
    final bgPaint = Paint()
      ..color = isSelected
          ? node.defaultColor
          : node.defaultColor.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, size, bgPaint);

    // 노드 테두리
    final borderPaint = Paint()
      ..color = node.defaultColor.withValues(alpha: 1.0)
      ..strokeWidth = isSelected ? 3.0 : 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(position, size, borderPaint);

    // 노드 아이콘 (타입에 따라)
    _drawNodeIcon(canvas, node, position, size);

    // 노드 제목 (항상 표시)
    _drawNodeTitle(canvas, node.title, position, size);

    // 노드 값 (선택되었을 때만)
    if (isSelected && node.value != null) {
      _drawNodeValue(canvas, node.formattedValue, position, size);
    }
  }

  void _drawNodeIcon(Canvas canvas, GraphNode node, Offset position, double size) {
    IconData icon;
    switch (node.type) {
      case NodeType.dataSource:
        icon = Icons.data_object;
        break;
      case NodeType.analysis:
        icon = Icons.analytics;
        break;
      case NodeType.conclusion:
        icon = Icons.check_circle;
        break;
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size * 0.5,
          fontFamily: icon.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawNodeTitle(Canvas canvas, String title, Offset position, double size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    textPainter.layout(maxWidth: size * 3);
    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy + size + 8,
      ),
    );
  }

  void _drawNodeValue(Canvas canvas, String value, Offset position, double size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: value,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy + size + 32,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant InsightGraphPainter oldDelegate) {
    return oldDelegate.selectedNodeId != selectedNodeId ||
           oldDelegate.selectedEdgeId != selectedEdgeId ||
           oldDelegate.nodes != nodes ||
           oldDelegate.edges != edges;
  }
}

extension on Offset {
  double dot(Offset other) => dx * other.dx + dy * other.dy;
}
