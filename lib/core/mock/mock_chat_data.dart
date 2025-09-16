import 'dart:math';

class MockChatData {
  static const String userId = 'user_001';
  
  // 상담 대화 이력 (최근 2주간 10건)
  static List<Map<String, dynamic>> getChatHistory() {
    final chatHistory = <Map<String, dynamic>>[];
    final now = DateTime.now();
    
    // 실제와 같은 건강 상담 대화들
    final conversations = [
      {
        'date': now.subtract(const Duration(days: 1)),
        'messages': [
          {
            'isUser': true,
            'text': '요즘 다이어트 중인데 저녁을 많이 먹은 것 같아서 걱정돼요. 어떻게 해야 할까요?',
            'timestamp': now.subtract(const Duration(days: 1, hours: 2)),
            'keywords': ['다이어트', '저녁식사', '과식'],
          },
          {
            'isUser': false,
            'text': '다이어트 중에 가끔 많이 먹게 되는 것은 자연스러운 일이에요. 중요한 것은 다음날부터 다시 규칙적인 식단을 유지하는 것입니다. 오늘 드신 식단을 보니 전체적으로는 목표 칼로리와 비슷하네요. 내일부터는 저녁을 조금 일찍, 그리고 천천히 드셔보세요.',
            'timestamp': now.subtract(const Duration(days: 1, hours: 2, minutes: 2)),
            'aiResponse': true,
          },
          {
            'isUser': true,
            'text': '감사해요. 그럼 내일 아침운동을 더 해야 할까요?',
            'timestamp': now.subtract(const Duration(days: 1, hours: 1, minutes: 58)),
            'keywords': ['운동', '보상', '계획'],
          },
          {
            'isUser': false,
            'text': '굳이 더 운동하실 필요는 없어요. 평소와 같이 꾸준히 하시는 것이 더 중요합니다. 급작스럽게 운동량을 늘리면 오히려 부상 위험이 있어요. 대신 내일 식사 때 물을 충분히 드시고, 채소를 먼저 드시는 습관을 만들어보세요.',
            'timestamp': now.subtract(const Duration(days: 1, hours: 1, minutes: 56)),
            'aiResponse': true,
          }
        ],
      },
      {
        'date': now.subtract(const Duration(days: 3)),
        'messages': [
          {
            'isUser': true,
            'text': '수면 패턴이 불규칙해서 걱정돼요. 매일 다른 시간에 자고 있어요.',
            'timestamp': now.subtract(const Duration(days: 3, hours: 10)),
            'keywords': ['수면패턴', '불규칙', '수면시간'],
          },
          {
            'isUser': false,
            'text': '최근 일주일 수면 데이터를 보니 취침 시간이 평균 1시간 정도 차이가 나고 있네요. 불규칙한 수면 패턴은 신체 리듬을 방해할 수 있어요. 일주일에 3-4일만이라도 같은 시간에 잠자리에 들어보세요. 주말에도 평일과 2시간 이상 차이나지 않게 하시는 것이 좋습니다.',
            'timestamp': now.subtract(const Duration(days: 3, hours: 9, minutes: 58)),
            'aiResponse': true,
          },
          {
            'isUser': true,
            'text': '회사 야근 때문에 어쩔 수 없을 때가 많아요.',
            'timestamp': now.subtract(const Duration(days: 3, hours: 9, minutes: 55)),
            'keywords': ['야근', '직장', '스트레스'],
          },
          {
            'isUser': false,
            'text': '야근이 불가피하다면, 적어도 기상 시간은 일정하게 유지해보세요. 그리고 야근하는 날에는 카페인 섭취를 오후 3시 이전으로 제한하시고, 잠자리에 들기 1시간 전에는 스마트폰 화면을 보지 마세요. 멜라토닌 생성에 도움이 됩니다.',
            'timestamp': now.subtract(const Duration(days: 3, hours: 9, minutes: 52)),
            'aiResponse': true,
          }
        ],
      },
      {
        'date': now.subtract(const Duration(days: 5)),
        'messages': [
          {
            'isUser': true,
            'text': '단백질을 더 많이 섭취하고 싶은데 어떤 음식이 좋을까요?',
            'timestamp': now.subtract(const Duration(days: 5, hours: 15)),
            'keywords': ['단백질', '영양소', '음식추천'],
          },
          {
            'isUser': false,
            'text': '현재 일평균 단백질 섭취량이 목표량의 80% 정도네요. 닭가슴살, 계란, 두부, 연어 등이 좋은 단백질 공급원입니다. 특히 운동 후에는 30분 이내에 단백질을 섭취하시면 근육 회복에 도움이 됩니다. 간식으로는 그릭요거트나 견과류를 추천드려요.',
            'timestamp': now.subtract(const Duration(days: 5, hours: 14, minutes: 58)),
            'aiResponse': true,
          }
        ],
      },
      {
        'date': now.subtract(const Duration(days: 7)),
        'messages': [
          {
            'isUser': true,
            'text': '요즘 스트레스를 많이 받아서 폭식을 하게 돼요. 어떻게 관리해야 할까요?',
            'timestamp': now.subtract(const Duration(days: 7, hours: 8)),
            'keywords': ['스트레스', '폭식', '정서적섭식'],
          },
          {
            'isUser': false,
            'text': '스트레스성 폭식은 많은 분들이 겪는 문제예요. 우선 스트레스를 받을 때 음식 대신 다른 해소 방법을 찾아보세요. 깊은 호흡, 가벼운 산책, 음악 듣기 등이 도움될 수 있습니다. 그리고 정기적인 식사 시간을 지키셔서 과도한 배고픔을 피하는 것이 중요해요.',
            'timestamp': now.subtract(const Duration(days: 7, hours: 7, minutes: 58)),
            'aiResponse': true,
          },
          {
            'isUser': true,
            'text': '명상이나 요가도 도움이 될까요?',
            'timestamp': now.subtract(const Duration(days: 7, hours: 7, minutes: 55)),
            'keywords': ['명상', '요가', '스트레스해소'],
          },
          {
            'isUser': false,
            'text': '네, 명상과 요가는 스트레스 관리에 매우 효과적입니다. 하루 10-15분만이라도 꾸준히 하시면 스트레스 호르몬인 코르티솔 수치가 낮아져서 감정적 과식을 줄이는데 도움이 됩니다. 초보자라면 유튜브의 가이드 영상을 활용해보세요.',
            'timestamp': now.subtract(const Duration(days: 7, hours: 7, minutes: 52)),
            'aiResponse': true,
          }
        ],
      },
      {
        'date': now.subtract(const Duration(days: 9)),
        'messages': [
          {
            'isUser': true,
            'text': '운동을 꾸준히 하고 있는데 체중이 잘 안 빠져요.',
            'timestamp': now.subtract(const Duration(days: 9, hours: 19)),
            'keywords': ['체중감량', '운동', '정체기'],
          },
          {
            'isUser': false,
            'text': '체중 감량에는 시간이 걸리고, 때로는 정체기가 있을 수 있어요. 최근 2주간 데이터를 보니 꾸준히 운동하고 계시고, 근육량도 약간 증가한 것 같아요. 근육이 늘면서 체중은 그대로지만 체지방은 감소할 수 있습니다. 체중계 숫자보다는 전체적인 몸의 변화를 관찰해보세요.',
            'timestamp': now.subtract(const Duration(days: 9, hours: 18, minutes: 58)),
            'aiResponse': true,
          }
        ],
      },
      {
        'date': now.subtract(const Duration(days: 12)),
        'messages': [
          {
            'isUser': true,
            'text': '물을 많이 마시라고 하는데 하루에 얼마나 마셔야 하나요?',
            'timestamp': now.subtract(const Duration(days: 12, hours: 14)),
            'keywords': ['수분섭취', '물', '하루권장량'],
          },
          {
            'isUser': false,
            'text': '일반적으로 성인 남성은 하루 2-2.5L 정도가 적당합니다. 운동을 하시는 날에는 추가로 500-700ml 더 드시면 좋아요. 한 번에 많이 마시기보다는 자주 조금씩 마시는 것이 좋고, 식사 30분 전후로는 너무 많이 마시지 마세요. 소화에 방해될 수 있거든요.',
            'timestamp': now.subtract(const Duration(days: 12, hours: 13, minutes: 58)),
            'aiResponse': true,
          }
        ],
      },
    ];
    
    // 대화 데이터를 데이터베이스 형태로 변환
    int conversationId = 1;
    for (var conversation in conversations) {
      chatHistory.add({
        'id': conversationId,
        'userId': userId,
        'startedAt': conversation['date'],
        'endedAt': (conversation['date'] as DateTime).add(const Duration(minutes: 15)),
        'totalMessages': (conversation['messages'] as List).length,
        'topic': _extractMainTopic((conversation['messages'] as List).cast<Map<String, dynamic>>()),
        'summary': _generateConversationSummary((conversation['messages'] as List).cast<Map<String, dynamic>>()),
        'messages': conversation['messages'],
        'satisfaction': 4 + Random(conversationId).nextInt(2), // 4-5점 만족도
      });
      conversationId++;
    }
    
    return chatHistory;
  }
  
  // 대화의 주요 주제 추출
  static String _extractMainTopic(List<Map<String, dynamic>> messages) {
    final topics = <String, int>{};
    
    for (var message in messages) {
      if (message['keywords'] != null) {
        for (String keyword in message['keywords']) {
          topics[keyword] = (topics[keyword] ?? 0) + 1;
        }
      }
    }
    
    if (topics.isEmpty) return '일반상담';
    
    // 가장 빈도가 높은 키워드를 주제로 설정
    var mainTopic = topics.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    
    // 주제 매핑
    final topicMap = {
      '다이어트': '식단관리',
      '수면': '수면관리', 
      '수면패턴': '수면관리',
      '운동': '운동상담',
      '단백질': '영양상담',
      '스트레스': '정신건강',
      '체중감량': '체중관리',
      '수분섭취': '생활습관',
    };
    
    return topicMap[mainTopic] ?? '일반상담';
  }
  
  // 대화 요약 생성
  static String _generateConversationSummary(List<Map<String, dynamic>> messages) {
    if (messages.isEmpty) return '';
    
    final userMessages = messages.where((m) => m['isUser'] == true).toList();
    if (userMessages.isEmpty) return '';
    
    // 첫 번째 사용자 메시지를 기반으로 요약 생성
    final firstUserMessage = userMessages.first['text'] as String;
    
    if (firstUserMessage.contains('다이어트')) {
      return '다이어트 중 식단 조절과 관련된 상담을 진행했습니다.';
    } else if (firstUserMessage.contains('수면')) {
      return '수면 패턴 개선과 수면의 질 향상에 대해 논의했습니다.';
    } else if (firstUserMessage.contains('운동')) {
      return '운동 계획과 체중 관리에 대한 조언을 제공했습니다.';
    } else if (firstUserMessage.contains('단백질')) {
      return '단백질 섭취 방법과 영양 균형에 대해 상담했습니다.';
    } else if (firstUserMessage.contains('스트레스')) {
      return '스트레스 관리와 정서적 과식 해결 방안을 제시했습니다.';
    } else {
      return '건강 관리 전반에 대한 상담을 진행했습니다.';
    }
  }
  
  // 상담 통계 데이터
  static Map<String, dynamic> getChatStatistics() {
    final chatHistory = getChatHistory();
    final now = DateTime.now();
    
    // 주제별 상담 횟수
    final topicCounts = <String, int>{};
    for (var chat in chatHistory) {
      final topic = chat['topic'] as String;
      topicCounts[topic] = (topicCounts[topic] ?? 0) + 1;
    }
    
    // 월별 상담 횟수 (최근 3개월)
    final monthlyChats = <String, int>{};
    for (int i = 0; i < 3; i++) {
      final monthDate = DateTime(now.year, now.month - i, 1);
      final monthKey = '${monthDate.year}-${monthDate.month.toString().padLeft(2, '0')}';
      monthlyChats[monthKey] = 0;
    }
    
    for (var chat in chatHistory) {
      final chatDate = chat['startedAt'] as DateTime;
      final monthKey = '${chatDate.year}-${chatDate.month.toString().padLeft(2, '0')}';
      if (monthlyChats.containsKey(monthKey)) {
        monthlyChats[monthKey] = monthlyChats[monthKey]! + 1;
      }
    }
    
    // 평균 만족도
    final satisfactionScores = chatHistory.map((c) => c['satisfaction'] as int).toList();
    final avgSatisfaction = satisfactionScores.reduce((a, b) => a + b) / satisfactionScores.length;
    
    return {
      'userId': userId,
      'totalChats': chatHistory.length,
      'averageSatisfaction': avgSatisfaction.toStringAsFixed(1),
      'topicDistribution': topicCounts,
      'monthlyChats': monthlyChats,
      'mostDiscussedTopic': topicCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      'totalChatTime': chatHistory.length * 15, // 평균 15분 가정
      'lastChatDate': chatHistory.isNotEmpty ? chatHistory.first['startedAt'] : null,
    };
  }
  
  // 자주 묻는 질문과 답변
  static List<Map<String, dynamic>> getFrequentQA() {
    return [
      {
        'category': '식단관리',
        'question': '다이어트 중에 간식을 먹어도 되나요?',
        'answer': '네, 건강한 간식을 적절히 드시는 것은 괜찮습니다. 견과류, 과일, 요거트 등을 추천드려요.',
        'frequency': 15,
      },
      {
        'category': '운동상담',
        'question': '운동은 언제 하는 것이 가장 좋나요?',
        'answer': '개인의 생활 패턴에 따라 다르지만, 일반적으로는 오전이나 오후 초반이 좋습니다.',
        'frequency': 12,
      },
      {
        'category': '수면관리',
        'question': '잠들기 전에 하면 안 되는 것이 있나요?',
        'answer': '카페인 섭취, 과식, 스마트폰 사용, 격렬한 운동 등은 피하시는 것이 좋습니다.',
        'frequency': 10,
      },
      {
        'category': '영양상담',
        'question': '하루에 물을 얼마나 마셔야 하나요?',
        'answer': '성인 남성 기준 하루 2-2.5L, 운동할 때는 추가로 500-700ml 더 드시면 좋습니다.',
        'frequency': 8,
      },
      {
        'category': '정신건강',
        'question': '스트레스받을 때 폭식하게 되는데 어떻게 해야 하나요?',
        'answer': '스트레스를 다른 방법으로 해소해보세요. 산책, 명상, 음악 감상 등이 도움됩니다.',
        'frequency': 6,
      },
    ];
  }
}