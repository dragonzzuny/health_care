# Repository Guidelines

## Project Structure & Module Organization
- `lib/` holds Dart sources; entry point is `lib/main.dart` with shared modules under `lib/core/`, feature folders under `lib/features/`, and reusable utilities in `lib/shared/`.
- Tests mirror sources inside `test/`, using the same feature-first layout for quick navigation.
- Static assets live in `assets/`; register new fonts or images in `pubspec.yaml` before use.
- Automation scripts and tooling live under `scripts/`; platform shells (`android/`, `ios/`, etc.) host native build configs.

## Build, Test, and Development Commands
- `flutter pub get` resolves package dependencies and should run after any `pubspec.yaml` change.
- `flutter analyze` applies `analysis_options.yaml` rules; resolve every warning before committing.
- `dart format .` enforces the repo-wide 2-space indentation; run prior to reviews to avoid churn.
- `flutter run -d chrome` launches the app on the web; swap the device id for other targets.
- `flutter test` or `flutter test --coverage` executes unit and widget suites; keep the tree green before merging.

## Coding Style & Naming Conventions
- Follow Dart style: 2-space indent, trailing commas in widget trees, `const` constructors when possible.
- Use `snake_case.dart` for files, `PascalCase` for classes, and `lowerCamelCase` for members and consts.
- Prefer small, composable widgets and keep shared logic inside `lib/core/` or `lib/shared/` for reuse.

## Testing Guidelines
- Use `flutter_test` with `group` and `test`/`testWidgets`; name files `*_test.dart` to match source locations.
- Write regression tests for bug fixes and add coverage for new business logic, especially in `lib/features/` flows.
- Generate coverage with `flutter test --coverage` when preparing reports; include artifacts in CI as needed.

## Commit & Pull Request Guidelines
- Commit messages follow Conventional Commits (`feat(chat): add search filter`) and should capture the intent of the change.
- PRs represent a single logical change, link issues (e.g., `Closes #123`), and provide screenshots or recordings for UI updates.
- Before opening a PR, run formatting, analysis, and tests locally; remove TODOs and confirm no secrets are added.

## Security & Configuration
- Never commit credentials; rely on `--dart-define` flags or untracked `.env` files for sensitive values.
- Configure Gemini/Gemma API access as described in `docs/gemini_api_setup.md`; inject `GEMINI_API_KEY` (and optional `GEMINI_MODEL_ID`) via `.env.local` or `--dart-define` only.
- Large model or asset downloads belong in `scripts/` utilities; reference them via constants in `lib/core/constants/app_constants.dart`.
