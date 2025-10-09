import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 개발자 모드 상태를 관리하는 StateNotifier
class DeveloperModeNotifier extends StateNotifier<bool> {
  DeveloperModeNotifier() : super(false) {
    _loadDeveloperMode();
  }

  static const String _key = 'developer_mode_enabled';

  /// 저장된 개발자 모드 상태 불러오기
  Future<void> _loadDeveloperMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = prefs.getBool(_key) ?? false;
    } catch (e) {
      state = false;
    }
  }

  /// 개발자 모드 토글
  Future<void> toggle() async {
    final newValue = !state;
    state = newValue;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, newValue);
    } catch (e) {
      // 저장 실패 시에도 상태는 변경된 상태 유지
      print('개발자 모드 저장 실패: $e');
    }
  }

  /// 개발자 모드 설정
  Future<void> setDeveloperMode(bool enabled) async {
    state = enabled;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, enabled);
    } catch (e) {
      print('개발자 모드 저장 실패: $e');
    }
  }
}

/// 개발자 모드 상태 프로바이더
final developerModeProvider = StateNotifierProvider<DeveloperModeNotifier, bool>((ref) {
  return DeveloperModeNotifier();
});
