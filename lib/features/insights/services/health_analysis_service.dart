import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/graph_node.dart';
import '../models/graph_edge.dart';
import '../models/insight_reasoning.dart';
import '../../../shared/models/health_data_model.dart';

/// 건강 데이터 분석 및 인사이트 생성 서비스
class HealthAnalysisService {
  final _uuid = const Uuid();

  /// 주간 건강 데이터를 분석하여 인사이트 생성
  Future<List<InsightReasoning>> analyzeWeeklyHealth({
    required List<HealthData> weeklyData,
    required Map<String, dynamic> activityReport,
    required Map<String, dynamic> nutritionReport,
  }) async {
    final insights = <InsightReasoning>[];

    // 1. 활동 패턴 분석
    final activityInsight = await _analyzeActivityPattern(
      weeklyData: weeklyData,
      activityReport: activityReport,
    );
    if (activityInsight != null) insights.add(activityInsight);

    // 2. 영양 균형 분석
    final nutritionInsight = await _analyzeNutritionBalance(
      weeklyData: weeklyData,
      nutritionReport: nutritionReport,
    );
    if (nutritionInsight != null) insights.add(nutritionInsight);

    // 3. 수면 품질 분석
    final sleepInsight = await _analyzeSleepQuality(weeklyData: weeklyData);
    if (sleepInsight != null) insights.add(sleepInsight);

    // 4. 종합 건강 상태 분석
    final overallInsight = await _analyzeOverallHealth(
      weeklyData: weeklyData,
      activityReport: activityReport,
      nutritionReport: nutritionReport,
    );
    if (overallInsight != null) insights.add(overallInsight);

    return insights;
  }

  /// 활동 패턴 분석
  Future<InsightReasoning?> _analyzeActivityPattern({
    required List<HealthData> weeklyData,
    required Map<String, dynamic> activityReport,
  }) async {
    if (weeklyData.isEmpty) return null;

    final nodes = <GraphNode>[];
    final edges = <GraphEdge>[];

    // 데이터 소스 노드 생성
    final avgSteps = activityReport['avgSteps'] ?? 0;
    final stepsProgress = activityReport['stepsProgress'] ?? 0.0;
    final totalActiveMinutes = activityReport['totalActiveMinutes'] ?? 0;
    final activeMinutesProgress = activityReport['activeMinutesProgress'] ?? 0.0;

    final stepsNode = GraphNode(
      id: _uuid.v4(),
      title: '평균 걸음 수',
      description: '일주일 동안의 평균 걸음 수',
      type: NodeType.dataSource,
      category: HealthCategory.activity,
      value: avgSteps,
      unit: '걸음',
      importance: 0.8,
      position: const Offset(50, 100),
    );
    nodes.add(stepsNode);

    final activeMinutesNode = GraphNode(
      id: _uuid.v4(),
      title: '활동 시간',
      description: '총 활동 시간 (분)',
      type: NodeType.dataSource,
      category: HealthCategory.activity,
      value: totalActiveMinutes,
      unit: '분',
      importance: 0.7,
      position: const Offset(50, 200),
    );
    nodes.add(activeMinutesNode);

    // 분석 노드 생성
    final activityLevelNode = GraphNode(
      id: _uuid.v4(),
      title: '활동 수준 평가',
      description: stepsProgress >= 0.9
          ? '목표를 초과 달성했습니다'
          : stepsProgress >= 0.7
              ? '목표에 근접했습니다'
              : '활동량이 부족합니다',
      type: NodeType.analysis,
      category: HealthCategory.activity,
      value: stepsProgress,
      importance: 0.9,
      position: const Offset(250, 150),
    );
    nodes.add(activityLevelNode);

    // 엣지 생성 (데이터 -> 분석)
    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: stepsNode.id,
      targetNodeId: activityLevelNode.id,
      type: EdgeType.inference,
      label: '평가',
      weight: 0.8,
      description: '걸음 수 데이터로부터 활동 수준을 평가',
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: activeMinutesNode.id,
      targetNodeId: activityLevelNode.id,
      type: EdgeType.inference,
      label: '평가',
      weight: 0.7,
      description: '활동 시간 데이터로부터 활동 수준을 평가',
    ));

    // 결론 노드 생성
    String conclusionTitle;
    String conclusionDesc;
    InsightPriority priority;
    List<String> recommendations;

    if (stepsProgress >= 0.9 && activeMinutesProgress >= 0.9) {
      conclusionTitle = '우수한 활동 패턴';
      conclusionDesc = '목표를 초과 달성하여 매우 건강한 활동 수준을 유지하고 있습니다';
      priority = InsightPriority.low;
      recommendations = [
        '현재 활동 수준을 유지하세요',
        '근력 운동을 추가하면 더 좋습니다',
        '주말에도 규칙적인 활동을 이어가세요',
      ];
    } else if (stepsProgress >= 0.7 || activeMinutesProgress >= 0.7) {
      conclusionTitle = '양호한 활동 패턴';
      conclusionDesc = '목표에 근접한 활동량으로 건강 관리를 잘하고 있습니다';
      priority = InsightPriority.medium;
      recommendations = [
        '평일 점심시간에 10분 산책을 추가해보세요',
        '계단 이용을 늘려보세요',
        '주 2-3회 유산소 운동을 권장합니다',
      ];
    } else {
      conclusionTitle = '활동량 증가 필요';
      conclusionDesc = '목표 대비 활동량이 부족합니다. 활동량을 점진적으로 늘려야 합니다';
      priority = InsightPriority.high;
      recommendations = [
        '매일 30분 걷기를 시작하세요',
        '엘리베이터 대신 계단을 이용하세요',
        '출퇴근 시 한 정거장 일찍 내려서 걸어보세요',
        '주차를 멀리 하여 걷는 거리를 늘리세요',
      ];
    }

    final conclusionNode = GraphNode(
      id: _uuid.v4(),
      title: conclusionTitle,
      description: conclusionDesc,
      type: NodeType.conclusion,
      category: HealthCategory.activity,
      importance: 1.0,
      position: const Offset(450, 150),
    );
    nodes.add(conclusionNode);

    // 분석 -> 결론 엣지
    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: activityLevelNode.id,
      targetNodeId: conclusionNode.id,
      type: EdgeType.causal,
      label: '결론',
      weight: 1.0,
      description: '활동 수준 평가로부터 최종 결론 도출',
    ));

    return InsightReasoning(
      id: _uuid.v4(),
      title: conclusionTitle,
      summary: conclusionDesc,
      detailedAnalysis: '''
일주일 동안의 활동 데이터를 분석한 결과:

• 평균 걸음 수: $avgSteps걸음 (목표 대비 ${(stepsProgress * 100).toInt()}%)
• 총 활동 시간: $totalActiveMinutes분 (목표 대비 ${(activeMinutesProgress * 100).toInt()}%)

${stepsProgress >= 0.9 ? '목표를 달성하여 매우 건강한 생활을 하고 계십니다.' : stepsProgress >= 0.7 ? '목표에 근접한 활동량으로 양호한 상태입니다.' : '활동량을 점진적으로 늘릴 필요가 있습니다.'}

규칙적인 활동은 심혈관 건강, 체중 관리, 정신 건강에 매우 중요합니다.
''',
      recommendations: recommendations,
      priority: priority,
      category: HealthCategory.activity,
      nodes: nodes,
      edges: edges,
      conclusionNodeId: conclusionNode.id,
      confidence: 0.85,
      generatedAt: DateTime.now(),
    );
  }

  /// 영양 균형 분석
  Future<InsightReasoning?> _analyzeNutritionBalance({
    required List<HealthData> weeklyData,
    required Map<String, dynamic> nutritionReport,
  }) async {
    if (weeklyData.isEmpty) return null;

    final nodes = <GraphNode>[];
    final edges = <GraphEdge>[];

    // 데이터 소스 노드
    final avgCalories = nutritionReport['avgCalories'] ?? 0;
    final avgProtein = nutritionReport['avgProtein'] ?? 0;
    final proteinProgress = nutritionReport['proteinProgress'] ?? 0.0;
    final carbsRatio = nutritionReport['carbsRatio'] ?? 0.0;
    final proteinRatio = nutritionReport['proteinRatio'] ?? 0.0;
    final fatRatio = nutritionReport['fatRatio'] ?? 0.0;

    final caloriesNode = GraphNode(
      id: _uuid.v4(),
      title: '평균 칼로리',
      description: '일일 평균 칼로리 섭취량',
      type: NodeType.dataSource,
      category: HealthCategory.nutrition,
      value: avgCalories,
      unit: 'kcal',
      importance: 0.8,
      position: const Offset(50, 100),
    );
    nodes.add(caloriesNode);

    final proteinNode = GraphNode(
      id: _uuid.v4(),
      title: '평균 단백질',
      description: '일일 평균 단백질 섭취량',
      type: NodeType.dataSource,
      category: HealthCategory.nutrition,
      value: avgProtein,
      unit: 'g',
      importance: 0.7,
      position: const Offset(50, 200),
    );
    nodes.add(proteinNode);

    final macroRatioNode = GraphNode(
      id: _uuid.v4(),
      title: '영양소 비율',
      description: '탄수화물 ${(carbsRatio * 100).toInt()}%, 단백질 ${(proteinRatio * 100).toInt()}%, 지방 ${(fatRatio * 100).toInt()}%',
      type: NodeType.dataSource,
      category: HealthCategory.nutrition,
      value: {'carbs': carbsRatio, 'protein': proteinRatio, 'fat': fatRatio},
      importance: 0.9,
      position: const Offset(50, 300),
    );
    nodes.add(macroRatioNode);

    // 분석 노드
    final balanceAnalysisNode = GraphNode(
      id: _uuid.v4(),
      title: '영양 균형 평가',
      description: _evaluateNutritionBalance(carbsRatio, proteinRatio, fatRatio),
      type: NodeType.analysis,
      category: HealthCategory.nutrition,
      importance: 0.9,
      position: const Offset(250, 200),
    );
    nodes.add(balanceAnalysisNode);

    // 엣지 생성
    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: caloriesNode.id,
      targetNodeId: balanceAnalysisNode.id,
      type: EdgeType.inference,
      label: '분석',
      weight: 0.6,
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: proteinNode.id,
      targetNodeId: balanceAnalysisNode.id,
      type: EdgeType.inference,
      label: '분석',
      weight: 0.8,
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: macroRatioNode.id,
      targetNodeId: balanceAnalysisNode.id,
      type: EdgeType.causal,
      label: '핵심 지표',
      weight: 1.0,
    ));

    // 결론 노드
    String conclusionTitle;
    String conclusionDesc;
    InsightPriority priority;
    List<String> recommendations;

    final isBalanced = _isNutritionBalanced(carbsRatio, proteinRatio, fatRatio);

    if (isBalanced && proteinProgress >= 0.9) {
      conclusionTitle = '우수한 영양 균형';
      conclusionDesc = '영양소 비율이 이상적이며 단백질 섭취도 충분합니다';
      priority = InsightPriority.low;
      recommendations = [
        '현재 식단을 유지하세요',
        '다양한 채소와 과일을 섭취하세요',
        '수분 섭취를 충분히 하세요',
      ];
    } else if (proteinProgress < 0.8) {
      conclusionTitle = '단백질 섭취 부족';
      conclusionDesc = '단백질 섭취량이 권장량보다 낮습니다';
      priority = InsightPriority.high;
      recommendations = [
        '매 끼니마다 단백질 식품을 포함하세요',
        '계란, 닭가슴살, 생선, 두부 등을 섭취하세요',
        '간식으로 그릭요거트나 견과류를 드세요',
        '필요시 단백질 보충제를 고려하세요',
      ];
    } else {
      conclusionTitle = '영양 균형 개선 필요';
      conclusionDesc = '일부 영양소 비율 조정이 필요합니다';
      priority = InsightPriority.medium;
      recommendations = [
        '탄수화물은 50-60%, 단백질 15-20%, 지방 20-30%를 목표로 하세요',
        '정제 탄수화물 대신 통곡물을 선택하세요',
        '건강한 지방(견과류, 올리브오일)을 섭취하세요',
      ];
    }

    final conclusionNode = GraphNode(
      id: _uuid.v4(),
      title: conclusionTitle,
      description: conclusionDesc,
      type: NodeType.conclusion,
      category: HealthCategory.nutrition,
      importance: 1.0,
      position: const Offset(450, 200),
    );
    nodes.add(conclusionNode);

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: balanceAnalysisNode.id,
      targetNodeId: conclusionNode.id,
      type: EdgeType.causal,
      label: '결론',
      weight: 1.0,
    ));

    return InsightReasoning(
      id: _uuid.v4(),
      title: conclusionTitle,
      summary: conclusionDesc,
      detailedAnalysis: '''
일주일 동안의 영양 섭취 데이터 분석 결과:

• 평균 칼로리: $avgCalories kcal
• 평균 단백질: ${avgProtein}g (목표 대비 ${(proteinProgress * 100).toInt()}%)
• 영양소 비율: 탄수화물 ${(carbsRatio * 100).toInt()}%, 단백질 ${(proteinRatio * 100).toInt()}%, 지방 ${(fatRatio * 100).toInt()}%

균형잡힌 영양 섭취는 건강 유지의 핵심입니다. ${isBalanced ? '현재 영양 균형이 우수합니다.' : '영양소 비율 조정이 필요합니다.'}
''',
      recommendations: recommendations,
      priority: priority,
      category: HealthCategory.nutrition,
      nodes: nodes,
      edges: edges,
      conclusionNodeId: conclusionNode.id,
      confidence: 0.82,
      generatedAt: DateTime.now(),
    );
  }

  /// 수면 품질 분석
  Future<InsightReasoning?> _analyzeSleepQuality({
    required List<HealthData> weeklyData,
  }) async {
    final sleepData = weeklyData
        .where((data) => data.sleepData != null)
        .map((data) => data.sleepData!)
        .toList();

    if (sleepData.isEmpty) return null;

    final nodes = <GraphNode>[];
    final edges = <GraphEdge>[];

    // 평균 수면 시간 계산
    final avgSleepHours = sleepData
            .map((s) => s.totalSleep.inMinutes / 60.0)
            .reduce((a, b) => a + b) /
        sleepData.length;

    final avgQuality = sleepData
            .map((s) => s.sleepQuality)
            .reduce((a, b) => a + b) /
        sleepData.length;

    // 데이터 소스 노드
    final sleepDurationNode = GraphNode(
      id: _uuid.v4(),
      title: '평균 수면 시간',
      description: '일일 평균 수면 시간',
      type: NodeType.dataSource,
      category: HealthCategory.sleep,
      value: avgSleepHours,
      unit: '시간',
      importance: 0.9,
      position: const Offset(50, 100),
    );
    nodes.add(sleepDurationNode);

    final sleepQualityNode = GraphNode(
      id: _uuid.v4(),
      title: '수면 품질',
      description: '평균 수면 품질 점수',
      type: NodeType.dataSource,
      category: HealthCategory.sleep,
      value: avgQuality,
      unit: '/5',
      importance: 0.8,
      position: const Offset(50, 200),
    );
    nodes.add(sleepQualityNode);

    // 분석 노드
    final sleepAssessmentNode = GraphNode(
      id: _uuid.v4(),
      title: '수면 상태 평가',
      description: _evaluateSleepQuality(avgSleepHours, avgQuality),
      type: NodeType.analysis,
      category: HealthCategory.sleep,
      importance: 0.9,
      position: const Offset(250, 150),
    );
    nodes.add(sleepAssessmentNode);

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: sleepDurationNode.id,
      targetNodeId: sleepAssessmentNode.id,
      type: EdgeType.causal,
      label: '영향',
      weight: 0.9,
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: sleepQualityNode.id,
      targetNodeId: sleepAssessmentNode.id,
      type: EdgeType.causal,
      label: '영향',
      weight: 0.8,
    ));

    // 결론
    String conclusionTitle;
    String conclusionDesc;
    InsightPriority priority;
    List<String> recommendations;

    if (avgSleepHours >= 7 && avgSleepHours <= 9 && avgQuality >= 4) {
      conclusionTitle = '우수한 수면 품질';
      conclusionDesc = '충분한 수면 시간과 높은 수면 품질을 유지하고 있습니다';
      priority = InsightPriority.low;
      recommendations = [
        '현재 수면 패턴을 유지하세요',
        '규칙적인 수면 시간을 지키세요',
      ];
    } else if (avgSleepHours < 7) {
      conclusionTitle = '수면 시간 부족';
      conclusionDesc = '권장 수면 시간보다 적게 자고 있습니다';
      priority = InsightPriority.high;
      recommendations = [
        '매일 7-8시간 수면을 목표로 하세요',
        '취침 1시간 전 스마트폰 사용을 줄이세요',
        '카페인은 오후 2시 이후 피하세요',
        '규칙적인 수면 시간을 정하세요',
      ];
    } else {
      conclusionTitle = '수면 품질 개선 필요';
      conclusionDesc = '수면 시간은 충분하나 품질 개선이 필요합니다';
      priority = InsightPriority.medium;
      recommendations = [
        '침실 온도를 18-22도로 유지하세요',
        '수면 환경을 어둡고 조용하게 만드세요',
        '규칙적인 운동을 하되 취침 3시간 전에는 피하세요',
        '취침 전 이완 루틴을 만드세요',
      ];
    }

    final conclusionNode = GraphNode(
      id: _uuid.v4(),
      title: conclusionTitle,
      description: conclusionDesc,
      type: NodeType.conclusion,
      category: HealthCategory.sleep,
      importance: 1.0,
      position: const Offset(450, 150),
    );
    nodes.add(conclusionNode);

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: sleepAssessmentNode.id,
      targetNodeId: conclusionNode.id,
      type: EdgeType.causal,
      label: '결론',
      weight: 1.0,
    ));

    return InsightReasoning(
      id: _uuid.v4(),
      title: conclusionTitle,
      summary: conclusionDesc,
      detailedAnalysis: '''
일주일 동안의 수면 데이터 분석 결과:

• 평균 수면 시간: ${avgSleepHours.toStringAsFixed(1)}시간
• 평균 수면 품질: ${avgQuality.toStringAsFixed(1)}/5점

권장 수면 시간은 성인 기준 7-9시간입니다. 양질의 수면은 면역력, 집중력, 정서 안정에 필수적입니다.
''',
      recommendations: recommendations,
      priority: priority,
      category: HealthCategory.sleep,
      nodes: nodes,
      edges: edges,
      conclusionNodeId: conclusionNode.id,
      confidence: 0.88,
      generatedAt: DateTime.now(),
    );
  }

  /// 종합 건강 상태 분석
  Future<InsightReasoning?> _analyzeOverallHealth({
    required List<HealthData> weeklyData,
    required Map<String, dynamic> activityReport,
    required Map<String, dynamic> nutritionReport,
  }) async {
    if (weeklyData.isEmpty) return null;

    final nodes = <GraphNode>[];
    final edges = <GraphEdge>[];

    // 각 영역별 점수
    final activityScore = _calculateActivityScore(activityReport);
    final nutritionScore = _calculateNutritionScore(nutritionReport);
    final sleepScore = _calculateSleepScore(weeklyData);

    // 데이터 소스 노드
    final activityScoreNode = GraphNode(
      id: _uuid.v4(),
      title: '활동 점수',
      description: '$activityScore점',
      type: NodeType.dataSource,
      category: HealthCategory.activity,
      value: activityScore,
      unit: '점',
      importance: 0.8,
      position: const Offset(50, 100),
    );
    nodes.add(activityScoreNode);

    final nutritionScoreNode = GraphNode(
      id: _uuid.v4(),
      title: '영양 점수',
      description: '$nutritionScore점',
      type: NodeType.dataSource,
      category: HealthCategory.nutrition,
      value: nutritionScore,
      unit: '점',
      importance: 0.8,
      position: const Offset(50, 200),
    );
    nodes.add(nutritionScoreNode);

    final sleepScoreNode = GraphNode(
      id: _uuid.v4(),
      title: '수면 점수',
      description: '$sleepScore점',
      type: NodeType.dataSource,
      category: HealthCategory.sleep,
      value: sleepScore,
      unit: '점',
      importance: 0.7,
      position: const Offset(50, 300),
    );
    nodes.add(sleepScoreNode);

    // 종합 점수 분석
    final overallScore = ((activityScore * 0.4) +
                          (nutritionScore * 0.4) +
                          (sleepScore * 0.2)).round();

    final overallAnalysisNode = GraphNode(
      id: _uuid.v4(),
      title: '종합 건강 점수',
      description: '$overallScore점 (100점 만점)',
      type: NodeType.analysis,
      category: HealthCategory.overall,
      value: overallScore,
      unit: '점',
      importance: 1.0,
      position: const Offset(250, 200),
    );
    nodes.add(overallAnalysisNode);

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: activityScoreNode.id,
      targetNodeId: overallAnalysisNode.id,
      type: EdgeType.causal,
      label: '40% 반영',
      weight: 0.8,
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: nutritionScoreNode.id,
      targetNodeId: overallAnalysisNode.id,
      type: EdgeType.causal,
      label: '40% 반영',
      weight: 0.8,
    ));

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: sleepScoreNode.id,
      targetNodeId: overallAnalysisNode.id,
      type: EdgeType.causal,
      label: '20% 반영',
      weight: 0.5,
    ));

    // 결론
    String conclusionTitle;
    String conclusionDesc;
    InsightPriority priority;
    List<String> recommendations;

    if (overallScore >= 85) {
      conclusionTitle = '매우 건강한 생활';
      conclusionDesc = '전반적으로 매우 우수한 건강 관리를 하고 있습니다';
      priority = InsightPriority.low;
      recommendations = [
        '현재 생활 습관을 유지하세요',
        '건강 검진을 정기적으로 받으세요',
        '새로운 운동이나 취미를 도전해보세요',
      ];
    } else if (overallScore >= 70) {
      conclusionTitle = '양호한 건강 상태';
      conclusionDesc = '전반적으로 건강한 생활을 하고 있으나 개선 여지가 있습니다';
      priority = InsightPriority.medium;
      recommendations = [
        '가장 낮은 점수의 영역에 집중하세요',
        '작은 목표부터 하나씩 개선하세요',
        '전문가 상담을 고려해보세요',
      ];
    } else {
      conclusionTitle = '건강 관리 필요';
      conclusionDesc = '여러 영역에서 개선이 필요합니다';
      priority = InsightPriority.high;
      recommendations = [
        '우선순위를 정해 단계적으로 개선하세요',
        '전문가의 도움을 받는 것을 권장합니다',
        '작은 변화부터 시작하여 습관을 만드세요',
        '가족이나 친구와 함께 건강 목표를 설정하세요',
      ];
    }

    final conclusionNode = GraphNode(
      id: _uuid.v4(),
      title: conclusionTitle,
      description: conclusionDesc,
      type: NodeType.conclusion,
      category: HealthCategory.overall,
      importance: 1.0,
      position: const Offset(450, 200),
    );
    nodes.add(conclusionNode);

    edges.add(GraphEdge(
      id: _uuid.v4(),
      sourceNodeId: overallAnalysisNode.id,
      targetNodeId: conclusionNode.id,
      type: EdgeType.causal,
      label: '최종 결론',
      weight: 1.0,
    ));

    return InsightReasoning(
      id: _uuid.v4(),
      title: conclusionTitle,
      summary: conclusionDesc,
      detailedAnalysis: '''
종합 건강 상태 분석 결과:

• 활동 점수: $activityScore/100
• 영양 점수: $nutritionScore/100
• 수면 점수: $sleepScore/100
• 종합 점수: $overallScore/100

각 영역의 균형잡힌 관리가 전체 건강에 중요합니다. ${overallScore >= 85 ? '현재 매우 우수한 상태를 유지하고 계십니다.' : overallScore >= 70 ? '전반적으로 양호하나 일부 개선이 필요합니다.' : '여러 영역에서 개선이 필요합니다.'}
''',
      recommendations: recommendations,
      priority: priority,
      category: HealthCategory.overall,
      nodes: nodes,
      edges: edges,
      conclusionNodeId: conclusionNode.id,
      confidence: 0.90,
      generatedAt: DateTime.now(),
    );
  }

  // 헬퍼 메서드들

  String _evaluateNutritionBalance(double carbsRatio, double proteinRatio, double fatRatio) {
    final issues = <String>[];

    if (carbsRatio > 0.65) issues.add('탄수화물 비율이 높음');
    if (carbsRatio < 0.45) issues.add('탄수화물 비율이 낮음');
    if (proteinRatio < 0.15) issues.add('단백질 비율이 낮음');
    if (proteinRatio > 0.30) issues.add('단백질 비율이 높음');
    if (fatRatio < 0.20) issues.add('지방 비율이 낮음');
    if (fatRatio > 0.35) issues.add('지방 비율이 높음');

    if (issues.isEmpty) return '영양소 비율이 균형잡혀 있습니다';
    return issues.join(', ');
  }

  bool _isNutritionBalanced(double carbsRatio, double proteinRatio, double fatRatio) {
    return carbsRatio >= 0.45 && carbsRatio <= 0.65 &&
           proteinRatio >= 0.15 && proteinRatio <= 0.30 &&
           fatRatio >= 0.20 && fatRatio <= 0.35;
  }

  String _evaluateSleepQuality(double avgHours, double avgQuality) {
    if (avgHours >= 7 && avgHours <= 9 && avgQuality >= 4) {
      return '수면 시간과 품질이 모두 우수합니다';
    } else if (avgHours < 7) {
      return '수면 시간이 부족합니다';
    } else if (avgQuality < 3) {
      return '수면 품질이 낮습니다';
    } else {
      return '수면 개선이 필요합니다';
    }
  }

  int _calculateActivityScore(Map<String, dynamic> report) {
    final stepsProgress = report['stepsProgress'] ?? 0.0;
    final activeMinutesProgress = report['activeMinutesProgress'] ?? 0.0;
    final caloriesProgress = report['caloriesProgress'] ?? 0.0;

    return ((stepsProgress + activeMinutesProgress + caloriesProgress) / 3 * 100).round();
  }

  int _calculateNutritionScore(Map<String, dynamic> report) {
    final calorieProgress = report['calorieProgress'] ?? 0.0;
    final proteinProgress = report['proteinProgress'] ?? 0.0;

    final calorieScore = _getProgressScore(calorieProgress);
    final proteinScore = _getProgressScore(proteinProgress);

    return ((calorieScore + proteinScore) / 2 * 100).round();
  }

  int _calculateSleepScore(List<HealthData> weeklyData) {
    final sleepData = weeklyData
        .where((data) => data.sleepData != null)
        .map((data) => data.sleepData!)
        .toList();

    if (sleepData.isEmpty) return 70; // 기본 점수

    final avgHours = sleepData
            .map((s) => s.totalSleep.inMinutes / 60.0)
            .reduce((a, b) => a + b) /
        sleepData.length;

    final avgQuality = sleepData
            .map((s) => s.sleepQuality)
            .reduce((a, b) => a + b) /
        sleepData.length;

    // 수면 시간 점수 (7-9시간이 최적)
    double hourScore;
    if (avgHours >= 7 && avgHours <= 9) {
      hourScore = 1.0;
    } else if (avgHours >= 6 && avgHours < 7) {
      hourScore = 0.8;
    } else if (avgHours > 9 && avgHours <= 10) {
      hourScore = 0.8;
    } else {
      hourScore = 0.6;
    }

    // 품질 점수 (5점 만점 기준)
    final qualityScore = avgQuality / 5.0;

    return ((hourScore * 0.6 + qualityScore * 0.4) * 100).round();
  }

  double _getProgressScore(double progress) {
    if (progress >= 0.8 && progress <= 1.2) {
      return 1.0;
    } else if (progress >= 0.6 && progress < 0.8) {
      return 0.8;
    } else if (progress > 1.2 && progress <= 1.5) {
      return 0.8;
    } else {
      return 0.6;
    }
  }
}
