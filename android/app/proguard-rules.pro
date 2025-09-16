# Google ML Kit - 누락된 클래스들 무시
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**

# Google ML Kit 기본 유지
-keep class com.google.mlkit.vision.text.** { *; }

# Google Play Core - 누락된 클래스들 무시
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Health package
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# 일반적인 경고 무시
-dontwarn java.lang.invoke.StringConcatFactory