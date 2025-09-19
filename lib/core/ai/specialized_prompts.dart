import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Gemma3 모델을 위한 특화된 프롬프트 생성 서비스
/// 각 기능별로 최적화된 프롬프트를 생성하여 AI 응답 품질을 향상
class SpecializedPrompts {
  final Logger _logger = Logger();

  /// 식단 추천을 위한 전문 프롬프트 생성
  String buildDietPrompt(Map<String, dynamic> processedData) {
    _logger.i('Building specialized diet prompt');

    final userProfile = processedData['userProfile'];
    final healthMetrics = processedData['healthMetrics'];
    final mealType = processedData['mealType'];
    final mealCalories = processedData['mealCalories'];
    final macroTargets = processedData['macroTargets'];
    final restrictions = processedData['restrictions'];
    final nutritionalGoals = processedData['nutritionalGoals'];
    final context = processedData['context'];

    return '''
당신은 SignCare의 전문 영양사 AI입니다. 다음 사용자 정보를 바탕으로 맞춤형 식단을 추천해주세요.

$context

## 요청 정보
**식사 유형**: $mealType
**목표 칼로리**: ${mealCalories.toStringAsFixed(0)}kcal
**매크로 영양소 목표**:
- 탄수화물: ${macroTargets['carbs']?.toStringAsFixed(0)}g
- 단백질: ${macroTargets['protein']?.toStringAsFixed(0)}g
- 지방: ${macroTargets['fat']?.toStringAsFixed(0)}g

**식이 제한사항**:
- 알레르기: ${restrictions['allergens']?.join(', ') ?? '없음'}
- 식이 선호: ${restrictions['dietary']?.join(', ') ?? '없음'}
- 의료적 제한: ${restrictions['medical']?.join(', ') ?? '없음'}

**영양 목표**: ${nutritionalGoals['type'] ?? '건강 유지'}

## 응답 형식
다음 구조로 응답해주세요:

### 🍽️ 추천 식단
**메인 요리**: [구체적인 요리명과 분량]
**사이드 요리**: [반찬이나 부식]
**음료**: [추천 음료]

### 📊 영양 정보
- 총 칼로리: [예상 칼로리]kcal
- 탄수화물: [예상량]g
- 단백질: [예상량]g
- 지방: [예상량]g

### 🥘 조리법 팁
[간단한 조리법이나 식재료 팁]

### ⚠️ 주의사항
[식이 제한사항에 따른 주의점]

### 🔄 대체 옵션
[비슷한 영양가의 대체 식단 1-2가지]

## 추가 고려사항
- 한국인의 식습관과 입맛을 고려해주세요
- 구하기 쉬운 식재료를 우선으로 해주세요
- 조리 시간은 30분 이내로 제한해주세요
- 계절성 식재료를 활용해주세요

식단 추천을 시작해주세요.''';
  }

  /// 운동 계획을 위한 전문 프롬프트 생성
  String buildExercisePrompt(Map<String, dynamic> processedData) {
    _logger.i('Building specialized exercise prompt');

    final userProfile = processedData['userProfile'];
    final fitnessLevel = processedData['fitnessLevel'];
    final fitnessAnalysis = processedData['fitnessAnalysis'];
    final availableTime = processedData['availableTime'];
    final timeAnalysis = processedData['timeAnalysis'];
    final equipment = processedData['equipment'];
    final equipmentOptions = processedData['equipmentOptions'];
    final goals = processedData['goals'];
    final goalPriorities = processedData['goalPriorities'];
    final context = processedData['context'];

    return '''
당신은 SignCare의 전문 운동 트레이너 AI입니다. 다음 사용자 정보를 바탕으로 맞춤형 운동 계획을 수립해주세요.

$context

## 운동 계획 요청 정보
**체력 수준**: $fitnessLevel (권장 강도: ${(fitnessAnalysis['intensity'] * 100).toStringAsFixed(0)}%)
**목표 심박수**: ${fitnessAnalysis['recommendedHeartRate']['target']}bpm
**주간 가능 시간**: 총 ${timeAnalysis['totalWeeklyMinutes']}분 (${timeAnalysis['activeDays']}일)

**요일별 시간**:
${_formatWeeklySchedule(availableTime)}

**보유 운동기구**:
${equipment.isEmpty ? '맨몸 운동만 가능' : equipment.join(', ')}

**운동 목표**:
- 주요 목표: ${goalPriorities['primary']}
- 부차 목표: ${goalPriorities['secondary']?.join(', ') ?? '없음'}

## 응답 형식
다음 구조로 응답해주세요:

### 📅 주간 운동 계획 개요
**총 운동 일수**: [X]일
**주간 운동 시간**: [총 시간]분
**운동 유형 배분**: [유산소:근력:유연성 비율]

### 🗓️ 요일별 상세 계획

**월요일** (${availableTime['monday'] ?? 0}분)
- 운동 유형: [유산소/근력/휴식]
- 주요 운동: [구체적 운동명]
- 강도: [초급/중급/고급]
- 세부 루틴: [세트, 횟수, 시간]

**화요일** (${availableTime['tuesday'] ?? 0}분)
[위와 동일한 형식으로 모든 요일 작성]

### 💪 운동별 가이드

**[운동명 1]**
- 목표 부위: [근육군]
- 실행 방법: [단계별 설명]
- 주의사항: [부상 예방 팁]
- 초보자 수정법: [쉬운 버전]

### 📈 진행 단계
**1주차 (적응기)**:
- 강도: 70% 수준
- 중점: 올바른 자세 습득

**2-3주차 (발전기)**:
- 강도: 80% 수준
- 중점: 지구력 향상

**4주차 이후 (유지기)**:
- 강도: 90% 수준
- 중점: 목표 달성

### ⚠️ 안전 수칙
- 운동 전후 워밍업/쿨다운 필수
- 통증 발생시 즉시 중단
- 충분한 수분 섭취
- 주 1-2회 완전 휴식일

### 📊 진도 체크 방법
[성과 측정 방법과 주기적 평가 기준]

## 추가 고려사항
- 한국인의 생활 패턴을 고려해주세요
- 실내/실외 운동 옵션을 모두 제공해주세요
- 날씨나 계절에 구애받지 않는 대안을 포함해주세요
- 운동 초보자도 쉽게 따라할 수 있도록 설명해주세요

운동 계획 수립을 시작해주세요.''';
  }

  /// 수면 개선을 위한 전문 프롬프트 생성
  String buildSleepPrompt(Map<String, dynamic> processedData) {
    _logger.i('Building specialized sleep prompt');

    final userProfile = processedData['userProfile'];
    final sleepPatterns = processedData['sleepPatterns'];
    final sleepAnalysis = processedData['sleepAnalysis'];
    final sleepIssues = processedData['sleepIssues'];
    final issuePriorities = processedData['issuePriorities'];
    final lifestyle = processedData['lifestyle'];
    final lifestyleImpact = processedData['lifestyleImpact'];
    final sleepGoals = processedData['sleepGoals'];
    final context = processedData['context'];

    return '''
당신은 SignCare의 전문 수면 상담사 AI입니다. 다음 사용자 정보를 바탕으로 수면 질 개선 방안을 제시해주세요.

$context

## 수면 분석 정보
**현재 수면 패턴**:
- 평균 수면 시간: ${sleepAnalysis['averageSleepHours']}시간
- 수면 효율성: ${sleepAnalysis['efficiency']}%
- 평균 취침 시간: ${sleepAnalysis['bedtime']}
- 평균 기상 시간: ${sleepAnalysis['wakeTime']}
- 수면 질 평가: ${sleepAnalysis['quality']}

**주요 수면 문제**:
- 1순위: ${issuePriorities['primary'] ?? '없음'}
- 2순위: ${issuePriorities['secondary']?.join(', ') ?? '없음'}
- 문제 심각도: ${issuePriorities['severity']}

**생활 패턴 영향 요소**:
${_formatLifestyleImpact(lifestyleImpact)}

**수면 목표**:
- 목표 수면 시간: ${sleepGoals['targetSleepHours']}시간
- 목표 수면 효율성: ${sleepGoals['targetEfficiency']}%
- 개선 필요도: ${sleepGoals['improvementNeeded'] ? '높음' : '낮음'}

## 응답 형식
다음 구조로 응답해주세요:

### 🎯 수면 개선 목표
**단기 목표 (1-2주)**:
- [구체적인 목표 1]
- [구체적인 목표 2]

**장기 목표 (1-3개월)**:
- [구체적인 목표 1]
- [구체적인 목표 2]

### 🛏️ 맞춤형 수면 스케줄
**권장 취침 시간**: [시간]
**권장 기상 시간**: [시간]
**수면 준비 시작 시간**: [취침 1시간 전]

### 📋 수면 위생 개선 방안

**취침 2-3시간 전**:
- [할 일 목록]
- [피해야 할 것들]

**취침 1시간 전**:
- [할 일 목록]
- [피해야 할 것들]

**취침 직전 (30분)**:
- [할 일 목록]
- [피해야 할 것들]

### 🏠 수면 환경 최적화
**침실 환경**:
- 온도: [권장 범위]
- 습도: [권장 범위]
- 조명: [권장 사항]
- 소음: [권장 사항]

**침구 및 설비**:
- [매트리스/베개 권장사항]
- [필요한 용품들]

### 🧘‍♀️ 수면 유도 기법
**호흡법**:
- [구체적인 호흡 기법]
- [실행 방법]

**이완 기법**:
- [근육 이완법]
- [명상 기법]

**인지 기법**:
- [걱정 멈추기 방법]
- [긍정적 사고 전환]

### 🍽️ 수면에 도움되는 생활습관
**식이 조절**:
- 취침 전 피해야 할 음식: [목록]
- 수면에 도움되는 음식: [목록]
- 카페인 섭취 제한: [시간 및 양]

**운동 가이드**:
- 수면에 도움되는 운동: [종류와 시간]
- 피해야 할 운동 시간: [언제, 왜]

### 📱 디지털 디톡스
**화면 시간 관리**:
- 블루라이트 차단: [방법]
- 기기 사용 중단 시간: [구체적 시간]
- 대체 활동: [추천 활동들]

### 📊 수면 모니터링
**추적할 지표**:
- [일일 체크 항목들]
- [주간 평가 항목들]

**개선 평가 방법**:
- [1주일 후 체크포인트]
- [1개월 후 체크포인트]

### 🚨 전문의 상담이 필요한 경우
- [증상 목록]
- [지속 기간 기준]
- [응급 상황 판단 기준]

## 추가 고려사항
- 한국인의 생활 패턴과 문화를 고려해주세요
- 실현 가능한 현실적인 조언을 제공해주세요
- 점진적인 변화를 통한 습관 형성을 강조해주세요
- 개인차를 인정하고 유연한 적용을 권장해주세요

수면 개선 방안 제시를 시작해주세요.''';
  }

  /// 건강 상담을 위한 전문 프롬프트 생성
  String buildConsultationPrompt(Map<String, dynamic> processedData) {
    _logger.i('Building specialized consultation prompt');

    final userMessage = processedData['userMessage'];
    final messageAnalysis = processedData['messageAnalysis'];
    final userProfile = processedData['userProfile'];
    final healthSummary = processedData['healthSummary'];
    final conversationSummary = processedData['conversationSummary'];
    final context = processedData['context'];

    return '''
당신은 SignCare의 전문 건강 상담사 AI입니다. 다음 사용자의 질문에 대해 전문적이고 정확한 상담을 제공해주세요.

$context

## 상담 요청 정보
**사용자 질문**: "$userMessage"

**질문 분석**:
- 분류: ${messageAnalysis['category']}
- 관련 주제: ${messageAnalysis['topics']?.join(', ') ?? '일반'}
- 긴급도: ${messageAnalysis['urgency']}
- 복잡도: ${messageAnalysis['complexity']}

**이전 대화 요약**:
${conversationSummary ?? '이전 대화 없음'}

## 상담 지침
1. **정확성**: 의학적으로 정확한 정보만 제공
2. **안전성**: 심각한 증상은 즉시 의료진 상담 권유
3. **개인화**: 사용자의 상황에 맞는 맞춤형 조언
4. **친근함**: 따뜻하고 이해하기 쉬운 언어 사용
5. **한계 인식**: AI의 한계를 명확히 안내

## 응답 형식
다음 구조로 응답해주세요:

### 🎯 질문 이해
[사용자 질문에 대한 간단한 요약과 이해]

### 🏥 전문 상담

${_getConsultationTemplate(messageAnalysis['category'])}

### 💡 추가 조언
**생활 개선 팁**:
- [실용적인 팁 1]
- [실용적인 팁 2]
- [실용적인 팁 3]

**예방 조치**:
- [예방법 1]
- [예방법 2]

### 🔍 추가 확인사항
**다음 상담시 확인할 것들**:
- [확인 항목 1]
- [확인 항목 2]

**모니터링할 증상**:
- [주의 깊게 관찰할 증상들]

### ⚠️ 주의사항
**즉시 병원 방문이 필요한 경우**:
- [응급 증상 목록]

**이 조언의 한계**:
- AI 상담은 의료진 진료를 대체할 수 없습니다
- 증상이 지속되거나 악화되면 반드시 의료진 상담을 받으세요

### 🔄 관련 건강 관리
**연관된 건강 관리 영역**:
${_getRelatedHealthAreas(messageAnalysis['topics'])}

## 추가 고려사항
- 의료진이 아님을 항상 명시하세요
- 불확실한 경우 전문의 상담을 권하세요
- 응급상황 의심시 즉시 119 또는 응급실 방문을 안내하세요
- 약물 처방이나 진단은 절대 하지 마세요

상담을 시작해주세요.''';
  }

  // ========== 보조 메서드들 ==========

  String _formatWeeklySchedule(Map<String, int> schedule) {
    final days = {
      'monday': '월',
      'tuesday': '화',
      'wednesday': '수',
      'thursday': '목',
      'friday': '금',
      'saturday': '토',
      'sunday': '일',
    };

    return days.entries
        .map((entry) => '${entry.value}: ${schedule[entry.key] ?? 0}분')
        .join('\n');
  }

  String _formatLifestyleImpact(Map<String, dynamic> impact) {
    final factors = impact['impactingFactors'] as Map<String, String>? ?? {};
    
    if (factors.isEmpty) {
      return '수면에 영향을 주는 특별한 생활 요소 없음';
    }

    return factors.entries
        .map((entry) => '- ${entry.key}: ${entry.value}')
        .join('\n');
  }

  String _getConsultationTemplate(String category) {
    switch (category) {
      case 'symptom_inquiry':
        return '''
**증상 분석**:
[증상에 대한 일반적인 원인과 특징 설명]

**가능한 원인들**:
- [원인 1]: [설명]
- [원인 2]: [설명]
- [원인 3]: [설명]

**권장 대응법**:
1. [즉시 할 수 있는 대응]
2. [단기적 관리 방법]
3. [장기적 예방 및 관리]

**병원 방문 기준**:
- [언제 병원을 가야 하는지]
- [어떤 과를 방문해야 하는지]''';

      case 'diet_inquiry':
        return '''
**영양학적 분석**:
[질문한 식품/식단에 대한 영양학적 평가]

**개인 맞춤 조언**:
- [사용자 상황에 맞는 식단 조언]
- [섭취량 가이드라인]
- [타이밍 권장사항]

**주의사항**:
- [특별히 주의해야 할 점들]
- [피해야 할 조합이나 상황]''';

      case 'exercise_inquiry':
        return '''
**운동 분석**:
[질문한 운동에 대한 전문적 분석]

**실행 가이드**:
- [올바른 실행 방법]
- [빈도와 강도 권장사항]
- [진행 단계별 가이드]

**주의사항**:
- [부상 예방법]
- [금기사항이나 제한사항]''';

      case 'sleep_inquiry':
        return '''
**수면 패턴 분석**:
[수면 문제에 대한 분석]

**개선 방안**:
- [즉시 적용 가능한 방법]
- [단계별 개선 계획]
- [환경 개선 조치]

**전문적 도움이 필요한 경우**:
- [수면 클리닉 방문 기준]
- [수면다원검사 필요성]''';

      default:
        return '''
**상담 내용**:
[질문에 대한 전문적이고 상세한 답변]

**실행 가능한 조치**:
- [구체적인 실행 방안들]

**추가 정보**:
- [도움이 될 수 있는 추가 정보]''';
    }
  }

  String _getRelatedHealthAreas(List<String>? topics) {
    if (topics == null || topics.isEmpty) {
      return '- 전반적인 건강 관리에 도움이 되는 식단, 운동, 수면 관리를 권장합니다';
    }

    final suggestions = <String>[];
    
    for (final topic in topics) {
      switch (topic) {
        case 'diabetes':
          suggestions.add('- 혈당 관리를 위한 식단 계획과 규칙적인 운동이 도움됩니다');
          break;
        case 'hypertension':
          suggestions.add('- 저염식 식단과 유산소 운동, 스트레스 관리가 중요합니다');
          break;
        case 'heart':
          suggestions.add('- 심장 건강을 위한 지중해식 식단과 적절한 운동량 조절이 필요합니다');
          break;
        case 'diet':
          suggestions.add('- 개인 맞춤형 식단 계획 수립을 통해 더 체계적인 관리가 가능합니다');
          break;
        case 'exercise':
          suggestions.add('- 체력 수준에 맞는 점진적 운동 계획으로 안전하고 효과적인 운동이 가능합니다');
          break;
        case 'sleep':
          suggestions.add('- 수면 위생 개선과 수면 환경 최적화를 통해 수면 질을 향상시킬 수 있습니다');
          break;
        case 'stress':
          suggestions.add('- 스트레스 관리를 위한 이완 기법과 규칙적인 운동, 충분한 수면이 도움됩니다');
          break;
      }
    }
    
    return suggestions.isEmpty 
        ? '- 전반적인 건강 관리에 도움이 되는 식단, 운동, 수면 관리를 권장합니다'
        : suggestions.join('\n');
  }
}

// Riverpod Provider
final specializedPromptsProvider = Provider<SpecializedPrompts>((ref) {
  return SpecializedPrompts();
});