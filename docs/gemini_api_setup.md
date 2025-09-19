# Gemini API Setup

이 문서는 SignCare 상담 챗봇이 Google Gemini API(또는 Gemma 계열 모델)를 통해 실시간 응답을 생성하도록 설정하는 과정을 안내합니다. 모든 단계에서 **API 키는 절대 레포지토리에 커밋하지 마세요.**

## 1. API 키 발급
1. [Google AI Studio](https://aistudio.google.com/) 혹은 Google Cloud Console에서 Gemini API 키를 생성합니다.
2. 발급된 키는 안전한 장소에 보관합니다. 키가 노출되면 즉시 폐기하고 새 키를 발급받으세요.

## 2. 환경 변수 구성
앱은 `AppConfig`를 통해 환경 변수를 읽어옵니다. 아래 옵션 중 편리한 방법을 선택하세요.

### 옵션 A — `.env.local` 파일 (개발용 권장)
프로젝트 루트에 `.env.local` 파일을 만들고 다음 내용을 추가합니다.

```
GEMINI_API_KEY=your_api_key_here
# 선택: 사용할 모델 (기본값은 gemini-2.0-flash)
GEMINI_MODEL_ID=gemma-2-2b-it
```

> `.env.local` 은 gitignore에 포함되어야 합니다. 이미 레포지토리에 포함된 키가 있다면 즉시 제거하고 새 키를 발급하세요.

### 옵션 B — 실행 시 `--dart-define`
CI나 배포 환경에서는 다음과 같이 전달할 수 있습니다.

```
flutter run \
  --dart-define=GEMINI_API_KEY=your_api_key_here \
  --dart-define=GEMINI_MODEL_ID=gemini-2.0-flash
```

> `GEMINI_MODEL_ID` 값은 `models/` 접두어를 빼고 입력하세요. 예: `gemma-2-2b-it`.

## 3. 앱 실행
1. `flutter pub get`으로 의존성을 정리합니다.
2. 위에서 설정한 방식으로 환경 변수를 지정한 뒤 `flutter run`을 실행합니다.
3. 상담 화면 상단 상태표시에 `Gemini 사용 가능`이 뜨면 API 연결이 완료된 것입니다.

## 4. 문제 해결
- **Gemini 사용 가능 표시가 보이지 않음**: `GEMINI_API_KEY`가 비어 있거나 잘못된 값일 수 있습니다. 로그에서 `AppConfig initialized` 메시지를 확인하세요.
- **403/429 오류**: 키 권한을 확인하거나 호출 제한을 조절하세요.
- **특정 Gemma 모델 사용 시 실패**: `GEMINI_MODEL_ID`가 정확한지, API에서 해당 모델을 지원하는지 확인하세요.

## 5. 보안 모범 사례
- API 키는 `.env.local`, CI 비밀 변수, 혹은 OS 환경 변수에만 저장하세요.
- 키가 노출되면 즉시 폐기하고 새 키를 발급하세요.
- 레포지토리에 키가 커밋되지 않았는지 항상 `git diff`로 확인하세요.

이 과정을 완료하면 SignCare 챗봇은 더 이상 하드코딩된 응답이 아닌 Gemini/Gemma 모델의 실시간 결과를 보여주게 됩니다.
