import 'package:flutter/material.dart';

/// 포션 크기를 선택하기 위한 시각적 가이드 위젯
class PortionInputWidget extends StatefulWidget {
  final int initialGrams;
  final ValueChanged<int> onChanged;
  final String foodName;
  final List<PortionPreset>? presets;

  const PortionInputWidget({
    super.key,
    required this.initialGrams,
    required this.onChanged,
    required this.foodName,
    this.presets,
  });

  @override
  State<PortionInputWidget> createState() => _PortionInputWidgetState();
}

class _PortionInputWidgetState extends State<PortionInputWidget> {
  late int _currentGrams;
  late List<PortionPreset> _presets;
  int? _selectedPresetIndex;

  @override
  void initState() {
    super.initState();
    _currentGrams = widget.initialGrams;
    _presets = widget.presets ?? _getDefaultPresets(widget.foodName);
    _updateSelectedPreset();
  }

  void _updateSelectedPreset() {
    _selectedPresetIndex = null;
    for (int i = 0; i < _presets.length; i++) {
      if ((_presets[i].grams - _currentGrams).abs() <= 10) {
        _selectedPresetIndex = i;
        break;
      }
    }
  }

  List<PortionPreset> _getDefaultPresets(String foodName) {
    // 음식 종류에 따른 기본 포션 프리셋
    final presets = <PortionPreset>[
      PortionPreset(
        label: '작은 접시',
        description: '아이 한 끼 분량',
        grams: 80,
        icon: Icons.circle,
        size: 0.6,
      ),
      PortionPreset(
        label: '보통 접시',
        description: '성인 한 끼 분량',
        grams: 150,
        icon: Icons.circle,
        size: 0.8,
      ),
      PortionPreset(
        label: '큰 접시',
        description: '든든한 한 끼',
        grams: 250,
        icon: Icons.circle,
        size: 1.0,
      ),
      PortionPreset(
        label: '대용량',
        description: '푸짐한 분량',
        grams: 400,
        icon: Icons.circle,
        size: 1.3,
      ),
    ];

    // 음식 종류별 커스텀 프리셋 (예시)
    if (foodName.toLowerCase().contains('rice') ||
        foodName.toLowerCase().contains('밥')) {
      presets[0] = presets[0].copyWith(
        label: '반 공기',
        description: '약 80g',
        grams: 80,
      );
      presets[1] = presets[1].copyWith(
        label: '한 공기',
        description: '약 150g',
        grams: 150,
      );
    }

    return presets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Row(
            children: [
              Icon(
                Icons.straighten,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '분량 선택',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_currentGrams}g',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 시각적 포션 가이드
          _buildVisualPortionGuide(),
          const SizedBox(height: 24),

          // 프리셋 버튼들
          Text(
            '빠른 선택',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          _buildPresetButtons(),
          const SizedBox(height: 20),

          // 정밀 조절 슬라이더
          Text(
            '정밀 조절',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          _buildPrecisionSlider(),
          const SizedBox(height: 16),

          // 칼로리 정보 (추정치)
          _buildCalorieInfo(),
        ],
      ),
    );
  }

  Widget _buildVisualPortionGuide() {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 접시들 (크기 비교용)
          for (int i = 0; i < _presets.length; i++)
            Positioned(
              left: 40.0 + (i * 60),
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  width: 40 * _presets[i].size,
                  height: 40 * _presets[i].size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

          // 현재 선택된 크기 표시
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60 + (_currentGrams / 500 * 60),
              height: 60 + (_currentGrams / 500 * 60),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.restaurant,
                color: Theme.of(context).colorScheme.primary,
                size: 24 + (_currentGrams / 500 * 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _presets.asMap().entries.map((entry) {
        final index = entry.key;
        final preset = entry.value;
        final isSelected = _selectedPresetIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _currentGrams = preset.grams;
              _selectedPresetIndex = index;
            });
            widget.onChanged(_currentGrams);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  preset.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                ),
                Text(
                  '${preset.grams}g',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrecisionSlider() {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            activeTrackColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            thumbColor: Theme.of(context).colorScheme.primary,
            overlayColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          child: Slider(
            value: _currentGrams.toDouble(),
            min: 20,
            max: 500,
            divisions: 48,
            label: '${_currentGrams}g',
            onChanged: (value) {
              setState(() {
                _currentGrams = value.round();
                _updateSelectedPreset();
              });
            },
            onChangeEnd: (value) {
              widget.onChanged(_currentGrams);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('20g', style: Theme.of(context).textTheme.bodySmall),
            Text('500g', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Widget _buildCalorieInfo() {
    // 대략적인 칼로리 계산 (실제로는 음식별 칼로리 데이터베이스 필요)
    final estimatedCalories = (_currentGrams * 2.5).round(); // 임시 계산

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department,
            color: Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '예상 칼로리',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            '약 $estimatedCalories kcal',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
          ),
        ],
      ),
    );
  }
}

/// 포션 프리셋 데이터 클래스
class PortionPreset {
  final String label;
  final String description;
  final int grams;
  final IconData icon;
  final double size; // 시각적 크기 배율

  const PortionPreset({
    required this.label,
    required this.description,
    required this.grams,
    required this.icon,
    this.size = 1.0,
  });

  PortionPreset copyWith({
    String? label,
    String? description,
    int? grams,
    IconData? icon,
    double? size,
  }) {
    return PortionPreset(
      label: label ?? this.label,
      description: description ?? this.description,
      grams: grams ?? this.grams,
      icon: icon ?? this.icon,
      size: size ?? this.size,
    );
  }
}

/// 즐겨찾는 포션을 관리하는 위젯
class FavoritePortionsWidget extends StatefulWidget {
  final String foodName;
  final List<int> favoritePortions;
  final ValueChanged<List<int>> onFavoritesChanged;
  final ValueChanged<int>? onPortionSelected;

  const FavoritePortionsWidget({
    super.key,
    required this.foodName,
    required this.favoritePortions,
    required this.onFavoritesChanged,
    this.onPortionSelected,
  });

  @override
  State<FavoritePortionsWidget> createState() => _FavoritePortionsWidgetState();
}

class _FavoritePortionsWidgetState extends State<FavoritePortionsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.favoritePortions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              '즐겨찾는 분량이 없습니다',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '자주 먹는 분량을 저장해보세요',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '자주 먹는 분량',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.favoritePortions.map((grams) {
            return GestureDetector(
              onTap: () => widget.onPortionSelected?.call(grams),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withOpacity(0.1),
                      Colors.pink.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.pink.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 14,
                      color: Colors.pink,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${grams}g',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
