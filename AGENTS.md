# Repository Guidelines

## Project Structure & Module Organization
- `lib/` — Dart sources. Entry point: `lib/main.dart`.
  - `lib/core/` — shared infrastructure (routing, theme, LLM, constants).
  - `lib/features/` — feature-first folders (e.g., `features/chat/presentation/...`).
  - `lib/shared/` — reusable models, providers, services, widgets.
- `assets/` — fonts and static assets (declared in `pubspec.yaml`).
- `test/` — unit/widget tests mirroring `lib/` structure.
- `scripts/` — utilities (e.g., `model_downloader_cli.dart`).
- Platform folders: `android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`.

## Build, Test, and Development Commands
- Install deps: `flutter pub get` — fetches packages.
- Analyze: `flutter analyze` — static analysis per `analysis_options.yaml`.
- Format: `dart format .` — formats Dart files (CI expects clean diff).
- Run (device/web): `flutter run -d <device>` (e.g., `chrome`, `android`).
- Tests: `flutter test` — runs unit/widget tests; coverage via `flutter test --coverage`.
- Android release: `flutter build apk --release`; iOS/macOS builds require Xcode on macOS.

## Coding Style & Naming Conventions
- Dart style with 2-space indent, trailing commas in Flutter widgets.
- File/folder names: `snake_case.dart`; classes: `PascalCase`; methods/fields/consts: `lowerCamelCase`.
- Keep widgets small and composable; prefer immutable `const` constructors when possible.
- Lint rules live in `analysis_options.yaml` — fix all hints/warnings before PR.

## Testing Guidelines
- Use `flutter_test` for unit and widget tests; place tests under `test/` mirroring `lib/`.
- Names: `*_test.dart`; group with `group(...)`, use `test(...)`/`testWidgets(...)`.
- Cover new business logic with unit tests and critical UI paths with widget tests. Aim for meaningful coverage; add regression tests for fixed bugs.

## Commit & Pull Request Guidelines
- Commit messages: Conventional Commits (e.g., `feat(auth): add login flow`, `fix(chat): null check in router`).
- One logical change per PR. Include description, linked issues (e.g., `Closes #123`), and screenshots/recordings for UI changes.
- Before opening a PR: run `dart format .`, `flutter analyze`, and `flutter test` locally; ensure no TODOs left in changed files.

## Security & Configuration
- Do not commit secrets. Use `--dart-define=KEY=VALUE` or local `.env` (untracked) for development.
- Large models/assets should be fetched via scripts in `scripts/` and referenced through `lib/core/constants/app_constants.dart` as needed.
