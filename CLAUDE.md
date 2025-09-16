# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SignCare is an AI-powered healthcare app built with Flutter for Android and iOS platforms. The app focuses on health management for diabetic patients and general users, featuring food recognition, health tracking, and AI-based health consultations.

## Development Commands

### Build and Run
```bash
# Run in debug mode
flutter run

# Run in release mode  
flutter run --release

# Run on specific device
flutter run -d <device_id>

# Build APK for Android
flutter build apk

# Build App Bundle for Android
flutter build appbundle

# Build for iOS
flutter build ios

# Build for Windows (if developing on Windows)
flutter build windows
```

### Code Generation and Dependencies
```bash
# Install dependencies
flutter pub get

# Generate code for Retrofit, Riverpod, Freezed, etc.
flutter packages pub run build_runner build

# Generate code with conflict resolution
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter packages pub run build_runner watch

# Clean and rebuild
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing and Analysis
```bash
# Run static analysis
flutter analyze

# Format code
dart format .

# Check formatting without modifying files
dart format --set-exit-if-changed .

# Run all tests
flutter test

# Run specific test file
flutter test test/models/user_model_test.dart

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### AI Model Management
```bash
# Download Gemma model
dart run scripts/model_downloader_cli.dart gemma

# Download EXAONE model  
dart run scripts/model_downloader_cli.dart exaone

# Run metal measurement script (Python)
python scripts/metal_measurement.py
```

## Architecture Overview

### State Management Pattern (Riverpod)
The app uses Riverpod for state management with the following patterns:
- **Providers** are defined in feature-specific files and exposed through `shared/providers/app_providers.dart`
- **StateNotifier** pattern for complex state management
- **ConsumerWidget/ConsumerStatefulWidget** for UI components that need reactive state
- **AsyncNotifier** for asynchronous state management with built-in loading/error states

### Navigation (GoRouter)
- Routes are centralized in `lib/core/router/app_router.dart`
- Uses declarative routing with path-based navigation
- ShellRoute wraps main app screens with `MainNavigation` for bottom navigation
- Route paths defined in `AppRoutes` class for type-safe navigation
- Error handling with custom error page

### API Integration Pattern
- **Dio** for HTTP client with interceptors for auth and logging
- **Retrofit** for type-safe API client generation
- API services are located in `shared/services/`
- Models use `freezed` and `json_serializable` for serialization
- WebSocket support via `web_socket_channel` for real-time features

### Feature Module Structure
Each feature follows a consistent structure:
```
features/<feature_name>/
├── presentation/     # UI screens and widgets
├── models/          # Data models  
├── providers/       # State management
└── services/        # Feature-specific services
```

### Food Recognition Architecture
The food recognition feature (`lib/features/food/presentation/food_screen.dart`) integrates:
- Google ML Kit for on-device object detection
- Camera/image picker for photo capture
- Server API (`POST /food/recognize`) for nutritional data
- Local nutrition database fallback (`assets/nutrition/`)
- YOLO support via `ultralytics_yolo` package

### LLM Integration
- Local models (Gemma 3B, EXAONE 3.5) via `lib/core/llm/`
- Model downloader service with progress tracking (`lib/core/llm/model_downloader.dart`)
- FFI integration for native model execution (`lib/core/llm/llama_cpp_ffi.dart`)
- Router pattern for switching between models (`lib/core/llm/llm_router.dart`)
- Models stored in `~/.signcare_models/`

### Database Architecture
- **Drift** for local SQLite database with type-safe queries
- Database files managed via `path_provider`
- Migrations handled through Drift's schema versioning
- Models with `@DataClassName` annotations for code generation

## Key Technical Decisions

### Platform-Specific Considerations
- **Windows**: Primary development platform (paths use backslashes)
- **Android**: Gradle wrapper available at `android/gradlew` and `android/gradlew.bat`
- **iOS**: Standard Flutter iOS setup with CocoaPods

### Asset Management
- Images stored in `assets/images/`
- Lottie animations in `assets/lottie/`
- Nutrition data in `assets/nutrition/`
- TensorFlow models in `assets/models/`
- Models downloaded to `~/.signcare_models/`

### Health Data Integration
- Uses `health` package for platform health APIs (Apple HealthKit, Google Fit)
- Permission handler for runtime permissions
- Charts via `fl_chart` and `syncfusion_flutter_charts`
- Sensor data from `geolocator` for location-based features

### Authentication Flow
- JWT-based authentication with token refresh
- Social login support (Google, Apple)
- Biometric authentication via platform APIs
- Token storage in secure storage via `shared_preferences`

## Code Style and Conventions

The project follows standard Flutter/Dart conventions:
- Snake_case for file names
- PascalCase for class names  
- camelCase for variables and methods
- Consistent use of `const` constructors where possible
- Analysis options from `flutter_lints` package
- Prefer single quotes for strings (when enabled in linter)

## Common Troubleshooting

### Build Issues
```bash
# Clean build artifacts and dependencies
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

# Fix iOS pod issues
cd ios && pod install && cd ..

# Reset Flutter configuration
flutter doctor -v

# Clear Gradle cache (Android)
cd android && ./gradlew clean && cd ..
```

### Windows Development
```bash
# Enable Windows desktop support
flutter config --enable-windows-desktop

# Build Windows executable
flutter build windows

# Run on Windows
flutter run -d windows
```