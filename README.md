# SignCare Flutter 헬스케어 앱 개발 가이드

## 프로젝트 개요

SignCare는 당뇨 환자와 건강 관리가 필요한 일반인을 위한 AI 기반 헬스케어 앱입니다. Flutter를 사용하여 Android 및 iOS에서 동작하는 크로스 플랫폼 앱으로 개발되었습니다.

## 주요 기능

### 1. 사용자 인증 및 프로필 관리
- 이메일/소셜 로그인
- 개인 건강 프로필 설정
- 생체 인증 지원

### 2. 건강 데이터 추적
- 일일 활동량 모니터링 (걸음 수, 칼로리)
- 식단 기록 및 영양 분석
- 운동 기록 및 추천
- 수면 패턴 분석
- 신체 측정 데이터 관리

### 3. AI 기반 건강 상담
- 실시간 채팅 상담
- 개인 맞춤형 건강 조언
- 증상 분석 및 권장사항

### 4. 리포트 및 분석
- 주간/월간/연간 건강 리포트
- 트렌드 분석 및 인사이트
- 목표 달성률 추적

### 5. 챌린지 및 동기부여
- 건강 챌린지 참여
- 목표 설정 및 달성
- 진행률 추적

## 기술 스택

### Frontend (Flutter)
- **Flutter 3.16+**: 크로스 플랫폼 UI 프레임워크
- **Dart 3.0+**: 프로그래밍 언어
- **Riverpod**: 상태 관리
- **Go Router**: 네비게이션
- **Dio**: HTTP 클라이언트
- **Retrofit**: API 클라이언트 생성
- **Shared Preferences**: 로컬 저장소
- **Permission Handler**: 권한 관리
- **Image Picker**: 이미지 선택
- **Charts Flutter**: 데이터 시각화

### Backend API
- **RESTful API**: HTTP 기반 API
- **JWT**: 인증 토큰
- **OAuth 2.0**: 소셜 로그인
- **WebSocket**: 실시간 통신

## 프로젝트 구조

```
lib/
├── core/                    # 핵심 설정 및 유틸리티
│   ├── constants/          # 앱 상수
│   ├── theme/             # 테마 설정
│   └── router/            # 라우팅 설정
├── features/              # 기능별 모듈
│   ├── auth/             # 인증
│   ├── activity/         # 활동 추적
│   ├── food/             # 식단 관리
│   ├── exercise/         # 운동 관리
│   ├── sleep/            # 수면 관리
│   ├── body/             # 신체 관리
│   ├── chat/             # AI 상담
│   ├── report/           # 리포트
│   └── challenge/        # 챌린지
├── shared/               # 공통 컴포넌트
│   ├── models/           # 데이터 모델
│   ├── services/         # API 서비스
│   ├── providers/        # 상태 관리
│   └── widgets/          # 공통 위젯
└── main.dart            # 앱 진입점
```

## 설치 및 실행

### 1. 개발 환경 설정

```bash
# Flutter SDK 설치 확인
flutter --version

# 프로젝트 의존성 설치
flutter pub get

# 코드 생성 (Retrofit, Riverpod 등)
flutter packages pub run build_runner build
```

### 2. 앱 실행

```bash
# 디버그 모드로 실행
flutter run

# 릴리즈 모드로 실행
flutter run --release

# 특정 디바이스에서 실행
flutter run -d <device_id>
```

### 3. 빌드

```bash
# Android APK 빌드
flutter build apk

# Android App Bundle 빌드
flutter build appbundle

# iOS 빌드
flutter build ios
```

### 4. AI 모델 다운로드

Gemma 3B와 EXAONE 3.5 모델을 로컬에서 사용하려면 아래 스크립트를 실행합니다.

```bash
# Gemma 모델 다운로드
dart run scripts/model_downloader_cli.dart gemma

# EXAONE 모델 다운로드
dart run scripts/model_downloader_cli.dart exaone
```

모델 파일은 `applicationDocumentsDirectory/models` 경로에 저장되며,
필요한 경우 [Ollama Gemma3 페이지](https://ollama.com/library/gemma3)와
[EXAONE 3.5 GitHub 저장소](https://github.com/LG-AI-EXAONE/EXAONE-3.5)를
참고하여 최신 다운로드 URL과 해시 값을 확인하세요.

## 개발 가이드

### 1. 코딩 컨벤션

- **파일명**: snake_case 사용
- **클래스명**: PascalCase 사용
- **변수명**: camelCase 사용
- **상수명**: UPPER_SNAKE_CASE 사용

### 2. 상태 관리 (Riverpod)

```dart
// Provider 정의
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

// 사용
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Text(user?.name ?? 'Guest');
  }
}
```

### 3. API 호출

```dart
// API 서비스 사용
final apiService = ref.watch(apiServiceProvider);
final healthData = await apiService.getHealthData(startDate, endDate);
```

### 4. 라우팅

```dart
// 화면 이동
context.go('/profile');
context.push('/settings');
```

## 테스트

### 1. 단위 테스트

```bash
# 모든 테스트 실행
flutter test

# 특정 테스트 파일 실행
flutter test test/models/user_model_test.dart

# 커버리지 포함 테스트
flutter test --coverage
```

### 2. 위젯 테스트

```dart
testWidgets('Login form validation', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // 이메일 필드에 잘못된 값 입력
  await tester.enterText(find.byKey(Key('email_field')), 'invalid-email');
  await tester.tap(find.byKey(Key('login_button')));
  await tester.pump();
  
  // 에러 메시지 확인
  expect(find.text('올바른 이메일을 입력하세요'), findsOneWidget);
});
```

### 3. 통합 테스트

```bash
# 통합 테스트 실행
flutter drive --target=test_driver/app.dart
```

## 배포

### 1. Android 배포

```bash
# 키스토어 생성
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# 앱 번들 빌드
flutter build appbundle

# Play Console에 업로드
```

### 2. iOS 배포

```bash
# iOS 빌드
flutter build ios --release

# Xcode에서 Archive 및 App Store Connect 업로드
```

## 주요 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.3
  dio: ^5.4.0
  retrofit: ^4.0.3
  json_annotation: ^4.8.1
  shared_preferences: ^2.2.2
  permission_handler: ^11.1.0
  image_picker: ^1.0.4
  charts_flutter: ^0.12.0
  tflite_flutter: ^0.10.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  retrofit_generator: ^8.0.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  mockito: ^5.4.4
```

## 문제 해결

### 1. 일반적인 문제

**빌드 오류**
```bash
# 캐시 정리
flutter clean
flutter pub get

# 코드 재생성
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**권한 문제**
- Android: `android/app/src/main/AndroidManifest.xml`에서 권한 확인
- iOS: `ios/Runner/Info.plist`에서 권한 확인

### 2. 성능 최적화

- 이미지 최적화: `flutter_image_compress` 사용
- 메모리 관리: 위젯 dispose 메서드 구현
- 네트워크 최적화: 캐싱 및 압축 활용

## 기여 가이드

1. 이슈 생성 또는 기존 이슈 확인
2. 브랜치 생성: `git checkout -b feature/새기능`
3. 코드 작성 및 테스트
4. 커밋: `git commit -m "feat: 새로운 기능 추가"`
5. 푸시: `git push origin feature/새기능`
6. Pull Request 생성

## 중금속 측정 데이터 조회 예제 (Python)

```bash
echo "SERVICE_KEY=<발급받은 서비스키>" > .env
python scripts/metal_measurement.py
```

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 연락처

- 개발팀: dev@signcare.com
- 지원: support@signcare.com
- 웹사이트: https://signcare.com

