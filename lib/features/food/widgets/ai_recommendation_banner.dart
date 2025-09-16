import 'package:flutter/material.dart';

/// AI 추천 메시지를 표시하는 배너 위젯
class AIRecommendationBanner extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool isDismissible;
  final VoidCallback? onDismiss;

  const AIRecommendationBanner({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.psychology,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.isDismissible = false,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? 
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);
    final fgColor = textColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: fgColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // AI 아이콘
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: fgColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: fgColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // 메시지 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: fgColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: fgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'AI',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: fgColor.withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // 액션 버튼들
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: fgColor.withValues(alpha: 0.6),
                    size: 16,
                  ),
                
                if (isDismissible && onDismiss != null)
                  GestureDetector(
                    onTap: onDismiss,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        color: fgColor.withValues(alpha: 0.6),
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 여러 AI 추천 타입을 위한 팩토리 클래스
class AIRecommendations {
  static AIRecommendationBanner nutritionTip({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AIRecommendationBanner(
      title: '영양 팁',
      message: message,
      icon: Icons.lightbulb_outline,
      backgroundColor: Colors.amber.withValues(alpha: 0.1),
      textColor: Colors.amber.shade700,
      onTap: onTap,
      isDismissible: true,
      onDismiss: onDismiss,
    );
  }

  static AIRecommendationBanner foodSuggestion({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AIRecommendationBanner(
      title: '음식 추천',
      message: message,
      icon: Icons.restaurant_menu,
      backgroundColor: Colors.green.withValues(alpha: 0.1),
      textColor: Colors.green.shade700,
      onTap: onTap,
      isDismissible: true,
      onDismiss: onDismiss,
    );
  }

  static AIRecommendationBanner healthAlert({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AIRecommendationBanner(
      title: '건강 알림',
      message: message,
      icon: Icons.health_and_safety,
      backgroundColor: Colors.red.withValues(alpha: 0.1),
      textColor: Colors.red.shade700,
      onTap: onTap,
      isDismissible: true,
      onDismiss: onDismiss,
    );
  }

  static AIRecommendationBanner cameraGuide({
    required String message,
    VoidCallback? onTap,
  }) {
    return AIRecommendationBanner(
      title: '촬영 가이드',
      message: message,
      icon: Icons.camera_alt,
      onTap: onTap,
    );
  }
}

/// AI 추천 리스트를 관리하는 위젯
class AIRecommendationList extends StatefulWidget {
  final List<AIRecommendationBanner> recommendations;
  final int maxVisible;
  final EdgeInsets? padding;

  const AIRecommendationList({
    super.key,
    required this.recommendations,
    this.maxVisible = 3,
    this.padding,
  });

  @override
  State<AIRecommendationList> createState() => _AIRecommendationListState();
}

class _AIRecommendationListState extends State<AIRecommendationList> {
  List<AIRecommendationBanner> _visibleRecommendations = [];

  @override
  void initState() {
    super.initState();
    _visibleRecommendations = widget.recommendations
        .take(widget.maxVisible)
        .toList();
  }

  void _dismissRecommendation(int index) {
    setState(() {
      _visibleRecommendations.removeAt(index);
      
      // 새로운 추천이 있다면 추가
      final remainingIndex = widget.maxVisible + 
          (widget.recommendations.length - _visibleRecommendations.length - 1);
      if (remainingIndex < widget.recommendations.length) {
        _visibleRecommendations.add(widget.recommendations[remainingIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_visibleRecommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: _visibleRecommendations.asMap().entries.map((entry) {
          final index = entry.key;
          final recommendation = entry.value;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: recommendation.isDismissible 
                ? Dismissible(
                    key: Key('recommendation_$index'),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _dismissRecommendation(index),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    child: recommendation,
                  )
                : recommendation,
          );
        }).toList(),
      ),
    );
  }
}

/// AI 추천 상태를 표시하는 간단한 배지 위젯
class AIBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final double size;

  const AIBadge({
    super.key,
    this.label = 'AI',
    this.color,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? Theme.of(context).colorScheme.primary;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.5,
        vertical: size * 0.2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            badgeColor,
            badgeColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.8),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.psychology,
            color: Colors.white,
            size: size * 0.8,
          ),
          SizedBox(width: size * 0.2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.7,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}