# Repository Guidelines

## Project Structure & Module Organization
This is a Flutter 2048 game. Main app code lives in `lib/`, with screens in `lib/screens/`, game UI components in `lib/components/`, state/managers in `lib/managers/`, models in `lib/models/`, constants in `lib/const/`, and generated/localized resources in `lib/resource/`. Static assets are under `assets/`, especially `assets/images/` and `assets/locale/`. Platform projects are in `android/` and `ios/`. The local shared package is `packages/core/flutter_core/`. Store/legal material lives in `store_assets/`, `legal/`, and `legal_site/`.

## Build, Test, and Development Commands
- `flutter pub get`: install Dart and Flutter dependencies.
- `flutter run`: run the app on a connected device or simulator.
- `flutter analyze`: run static analysis using `analysis_options.yaml`.
- `flutter test`: run Flutter tests.
- `dart run build_runner build --delete-conflicting-outputs`: regenerate generated files such as JSON/Hive/resource helpers when model or DI annotations change.
- `flutter build appbundle --release`: build the signed Android AAB at `build/app/outputs/bundle/release/app-release.aab`.

## Coding Style & Naming Conventions
Use Dart conventions with 2-space indentation and `flutter_lints`. File names should be `snake_case.dart`; classes, widgets, enums, and providers should be `UpperCamelCase`; methods and variables should be `lowerCamelCase`. Keep UI widgets small and place reusable pieces in `lib/components/`. Generated files such as `*.g.dart`, `assets.gen.dart`, and locale key files should not be hand-edited unless the generator is unavailable.

## Testing Guidelines
Use `flutter_test` for app tests and package tests. Place app tests in `test/` and package tests in the relevant package, for example `packages/core/flutter_core/test/`. Name tests with the `_test.dart` suffix. Prefer focused tests for board movement, score history, settings persistence, and onboarding flow. Run `flutter test` and `flutter analyze` before preparing a release build.

## Commit & Pull Request Guidelines
The current history uses short messages such as `fix: show score` plus simple descriptive commits. Prefer concise imperative messages, optionally with a scope or type, for example `fix: persist best score` or `chore: update release assets`. Pull requests should include a clear summary, testing notes, linked issues if any, and screenshots or screen recordings for UI changes.

## Security & Configuration Tips
Do not commit signing secrets. Keep `android/key.properties` local and use `android/key.properties.example` as the template. Release signing can also be supplied through environment variables: `ANDROID_KEYSTORE_PATH`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, and `ANDROID_KEY_PASSWORD`. Verify privacy and terms pages in `legal_site/` before deploying Firebase Hosting.
