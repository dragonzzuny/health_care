import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 영양소 정보를 원형 차트로 표시하는 위젯
class NutritionChart extends StatefulWidget {
  final double carbs;
  final double protein;
  final double fat;
  final double? fiber;
  final bool showAnimation;
  final double size;

  const NutritionChart({
    super.key,
    required this.carbs,
    required this.protein,
    required this.fat,
    this.fiber,
    this.showAnimation = true,
    this.size = 120,
  });

  @override
  State<NutritionChart> createState() => _NutritionChartState();
}

class _NutritionChartState extends State<NutritionChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    if (widget.showAnimation) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: NutritionChartPainter(
            carbs: widget.carbs,
            protein: widget.protein,
            fat: widget.fat,
            fiber: widget.fiber,
            animationValue: _animation.value,
          ),
        );
      },
    );
  }
}

class NutritionChartPainter extends CustomPainter {
  final double carbs;
  final double protein;
  final double fat;
  final double? fiber;
  final double animationValue;

  static const Color carbsColor = Colors.orange;
  static const Color proteinColor = Colors.blue;
  static const Color fatColor = Colors.green;
  static const Color fiberColor = Colors.purple;

  NutritionChartPainter({
    required this.carbs,
    required this.protein,
    required this.fat,
    this.fiber,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    
    final total = carbs + protein + fat + (fiber ?? 0);
    
    if (total == 0) return;

    // 각 영양소의 비율 계산
    final carbsRatio = carbs / total;
    final proteinRatio = protein / total;
    final fatRatio = fat / total;
    final fiberRatio = (fiber ?? 0) / total;

    double startAngle = -math.pi / 2; // 12시 방향부터 시작
    
    // 탄수화물 호 그리기
    _drawArc(canvas, center, radius, startAngle, carbsRatio * 2 * math.pi * animationValue, carbsColor);
    startAngle += carbsRatio * 2 * math.pi;
    
    // 단백질 호 그리기
    _drawArc(canvas, center, radius, startAngle, proteinRatio * 2 * math.pi * animationValue, proteinColor);
    startAngle += proteinRatio * 2 * math.pi;
    
    // 지방 호 그리기
    _drawArc(canvas, center, radius, startAngle, fatRatio * 2 * math.pi * animationValue, fatColor);
    startAngle += fatRatio * 2 * math.pi;
    
    // 식이섬유 호 그리기 (있는 경우)
    if (fiber != null && fiber! > 0) {
      _drawArc(canvas, center, radius, startAngle, fiberRatio * 2 * math.pi * animationValue, fiberColor);
    }

    // 중앙 원 그리기
    final centerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.6, centerCirclePaint);

    // 중앙 텍스트 그리기
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(carbs + protein + fat + (fiber ?? 0)).toStringAsFixed(0)}g',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawArc(Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle, Color color) {
    if (sweepAngle <= 0) return;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 영양소 정보와 차트를 함께 표시하는 카드 위젯
class NutritionInfoCard extends StatelessWidget {
  final String title;
  final double carbs;
  final double protein;
  final double fat;
  final double? fiber;
  final double totalCalories;
  final bool showChart;

  const NutritionInfoCard({
    super.key,
    required this.title,
    required this.carbs,
    required this.protein,
    required this.fat,
    this.fiber,
    required this.totalCalories,
    this.showChart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목과 총 칼로리
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${totalCalories.toStringAsFixed(0)} kcal',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                // 차트 (옵션)
                if (showChart) ...[
                  NutritionChart(
                    carbs: carbs,
                    protein: protein,
                    fat: fat,
                    fiber: fiber,
                    size: 100,
                  ),
                  const SizedBox(width: 24),
                ],
                
                // 영양소 정보
                Expanded(
                  child: Column(
                    children: [
                      _buildNutrientRow('탄수화물', carbs, Colors.orange, context),
                      const SizedBox(height: 12),
                      _buildNutrientRow('단백질', protein, Colors.blue, context),
                      const SizedBox(height: 12),
                      _buildNutrientRow('지방', fat, Colors.green, context),
                      if (fiber != null && fiber! > 0) ...[
                        const SizedBox(height: 12),
                        _buildNutrientRow('식이섬유', fiber!, Colors.purple, context),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientRow(String name, double value, Color color, BuildContext context) {
    final total = carbs + protein + fat + (fiber ?? 0);
    final percentage = total > 0 ? (value / total * 100) : 0;
    
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${value.toStringAsFixed(1)}g',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 영양소 진행률을 바 형태로 표시하는 위젯
class NutrientProgressBar extends StatelessWidget {
  final String name;
  final double current;
  final double target;
  final Color color;

  const NutrientProgressBar({
    super.key,
    required this.name,
    required this.current,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${current.toStringAsFixed(1)}g / ${target.toStringAsFixed(0)}g',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}