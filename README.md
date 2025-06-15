diff --git a/README.md b/README.md
index a31af4cb1c01e78b06bd7eaca7842bfd8c8ec76e..95b6d9247aa8fb952d813f777e3155e5190d4795 100644
--- a/README.md
+++ b/README.md
@@ -98,50 +98,67 @@ flutter packages pub run build_runner build
 
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
 
+### 4. AI 모델 다운로드
+
+Gemma 3B와 EXAONE 3.5 모델을 로컬에서 사용하려면 아래 스크립트를 실행합니다.
+
+```bash
+# Gemma 모델 다운로드
+dart run scripts/model_downloader_cli.dart gemma
+
+# EXAONE 모델 다운로드
+dart run scripts/model_downloader_cli.dart exaone
+```
+
+모델 파일은 사용자의 홈 디렉터리 하위 `~/.signcare_models` 폴더에 저장되며,
+필요한 경우 [Ollama Gemma3 페이지](https://ollama.com/library/gemma3)와
+[EXAONE 3.5 GitHub 저장소](https://github.com/LG-AI-EXAONE/EXAONE-3.5)를
+참고하여 최신 다운로드 URL과 해시 값을 확인하세요.
+
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
