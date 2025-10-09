# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SignCare is an AI-powered healthcare app built with Flutter for Android and iOS platforms. The app focuses on health management for diabetic patients and general users, featuring food recognition, health tracking, and AI-based health consultations.

### Features Overview
The app includes 13 main feature modules:
- **Authentication** (`/login`, `/register`): Email/social login, user registration
- **Activity Tracking** (`/activity`, `/home`): Daily activity monitoring, step counting, calorie tracking
- **Food Management** (`/food`): Camera-based food recognition, nutrition tracking, meal logging
- **Body Metrics** (`/body`): Weight, body measurements, health indicators
- **Sleep Tracking** (`/sleep`): Sleep pattern analysis and monitoring
- **AI Health Chat** (`/chat`): Real-time health consultations with local LLM models
- **Health Reports** (`/report`): Weekly/monthly health analytics and insights
- **Challenges** (`/challenge`): Goal setting, progress tracking, motivation features
- **Medication** (`/medication`): Medication reminders and tracking
- **Cosmetics** (`/cosmetics`): Cosmetic product safety and ingredient analysis
- **Weather** (`/weather`): Weather-based health recommendations
- **Insights** (`/insights`): Personalized health insights and trend analysis
- **Debug Tools** (`/database-debug`): Developer tools for database inspection

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
- **Core providers** in `shared/providers/app_providers.dart` include: Dio HTTP client, API service, auth state, health data, food recognition, and chat providers
- **Feature-specific providers** are located in `features/*/providers/` directories (e.g., `activity_providers.dart`, `food_providers.dart`, `chat_providers.dart`)
- **Infrastructure providers** in `shared/providers/` include: `database_providers.dart` for Drift database access, `developer_mode_provider.dart` for debug features
- **StateNotifier** pattern for complex state management with immutable state updates
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
- YOLO support via `ultralytics_yolo` package (temporarily disabled due to Java 17 requirement)

### Vision/Detection System
Core object detection system in `lib/core/vision/`:
- **Detector interface** (`detector.dart`): Abstract base class defining detection contract
- **YOLO detector** (`yolo_view_detector.dart`): Production YOLO model integration for real-time object detection
- **Mock detector** (`mock_detector.dart`): Testing implementation returning predefined results
- **Detection models** (`detection.dart`): Data classes for detection results with confidence scores
- This architecture allows swapping detection implementations without changing UI code

### LLM Integration
- Local models (Gemma 3B, EXAONE 3.5) via `lib/core/llm/`
- Model downloader service with progress tracking (`lib/core/llm/model_downloader.dart`)
- FFI integration for native model execution (`lib/core/llm/llama_cpp_ffi.dart`)
- Router pattern for switching between models (`lib/core/llm/llm_router.dart`)
- Models stored in `~/.signcare_models/`

### Database Architecture
The app uses **Drift** (formerly Moor) for a comprehensive local SQLite database:

**Schema Management:**
- Current schema version: **2**
- Database file: `signcare_app.db` in app documents directory
- WAL (Write-Ahead Logging) mode enabled for better performance
- Foreign key constraints enabled
- Automatic migrations with `MigrationStrategy`
- Initial data seeding on first launch

**Table Structure** (organized in `lib/core/database/tables/`):
- **Food tables**: Foods, FoodSynonyms, CommonPortions
- **Entry tables**: FoodEntries, FavoritePortions, DailyNutritionSummaries
- **Recognition tables**: RecognitionHistories, RecognitionResults, RecognitionFeedbacks
- **User tables**: UserPreferences, CustomFoods, UserFoodStatistics
- **Activity tables**: DailyActivities, WorkoutSessions, ActivityGoals, WeightRecords

**Key Features:**
- Type-safe query builder with compile-time verification
- Transaction support via `runInTransaction()` helper
- Database health check with `isDatabaseHealthy()`
- Backup functionality with `VACUUM INTO` for data export
- Statistics API with `getDatabaseStats()` for debugging
- Models use `@DataClassName` annotations for code generation
- Repository pattern in `lib/core/database/repositories/`

### Development & Debugging Tools
**Developer Mode:**
- Managed by `shared/providers/developer_mode_provider.dart`
- Enables debug features and advanced logging throughout the app
- Toggle via app settings or debug menu

**Database Debug Screen:**
- Route: `/database-debug` (defined in `app_router.dart`)
- Screen: `debug/database_debug_screen.dart`
- Features: View tables, inspect data, run queries, check database health
- Access database statistics and perform manual operations

**Mock Data:**
- Located in `lib/core/mock/` directory
- `mock_activity_data.dart`: Sample activity and workout data
- `mock_chat_data.dart`: Sample chat conversations for UI testing
- `mock_food_data.dart`: Sample food items and nutrition data
- `mock_sleep_data.dart`: Sample sleep patterns and records
- Used for development, testing, and offline mode

**Data Initializer:**
- Service: `lib/core/services/data_initializer.dart`
- Seeds initial data on first launch
- Populates default foods, portions, and reference data

## Key Technical Decisions

### Platform-Specific Considerations
- **Windows**: Primary development platform (paths use backslashes)
- **Android**: Gradle wrapper available at `android/gradlew` and `android/gradlew.bat`
- **iOS**: Standard Flutter iOS setup with CocoaPods

### Environment Configuration
The app uses `flutter_dotenv` for environment variable management:

**Setup:**
```bash
# Create .env file in project root
echo "SERVICE_KEY=your_service_key_here" > .env
echo "OPENAI_API_KEY=your_openai_api_key_here" >> .env
```

**Required Variables:**
- `SERVICE_KEY`: API key for external health data services (e.g., metal measurement API)
- `OPENAI_API_KEY`: OpenAI API key for cloud-based AI features

**Security Notes:**
- `.env` file is included in `.gitignore` to prevent committing secrets
- Never commit actual API keys to version control
- `.env` file must be created locally after cloning the repository
- The file is loaded at app startup via `flutter_dotenv` package

**OpenAI Integration:**
- Base URL: `https://api.openai.com/v1` (from `app_constants.dart`)
- Primary model: `gpt-5-nano` (most cost-effective)
- Fallback model: `gpt-4o-mini` (if primary unavailable)
- Default timeout: 60 seconds for AI responses
- Temperature: 0.7 for balanced creativity
- Max tokens: 1000 per response

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