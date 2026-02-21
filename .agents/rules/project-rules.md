---
trigger: always_on
---

# Tymer Project — Architecture Rules & Conventions

## 1. Project Structure (Monorepo with `packages/`)

```
tymer/
├── lib/                        # App entry (main.dart, routing_table.dart, firebase_options.dart)
└── packages/
    ├── features/               # One sub-package per screen/feature
    ├── domain_models/          # Pure Dart domain entities & exceptions
    ├── tymer_api/              # Raw HTTP layer (Dio + Remote Models)
    ├── user_repository/        # Business logic + cache bridge (per domain)
    ├── wallet_repository/
    ├── service_repository/
    ├── dispute_repository/
    ├── support_repository/
    ├── component_library/      # Shared reusable widgets
    ├── form_fields/            # Formz form field classes
    ├── key_value_storage/      # Abstracted local storage
    ├── function_and_extension_library/
    └── monitoring/
```

> **Rule**: Every new feature lives in its own sub-package under `packages/features/`. Do NOT put business logic in `lib/`.

---

## 2. Feature Package Structure

Every feature package follows this exact layout:

```
packages/features/<feature_name>/
├── pubspec.yaml
├── l10n.yaml
└── lib/
    ├── <feature_name>.dart          # Public barrel: exports screen + l10n only
    └── src/
        ├── <feature_name>_screen.dart   # Entry widget (StatelessWidget)
        ├── <feature_name>_cubit.dart    # Cubit + `part` import of state
        ├── <feature_name>_state.dart    # State class (part of cubit file)
        ├── components/
        │   ├── components.dart          # Barrel for all components
        │   └── lib/
        │       └── *.dart              # Individual sub-widgets
        └── l10n/
            ├── <feature_name>_localizations.dart
            └── arb/
                ├── <feature>_en.arb
                └── <feature>_ar.arb
```

**Barrel file rule** — `lib/<feature_name>.dart` exports ONLY:
```dart
export 'src/l10n/<feature>_localizations.dart';
export 'src/<feature>_screen.dart';
```

---

## 3. Feature Layer — Screen Widget

The screen widget is a **StatelessWidget** that:
- Accepts repositories and navigation callbacks as constructor params
- Creates the `Cubit` via `BlocProvider`
- Delegates visual work to a `*View` widget

```dart
class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.userRepository,
    required this.onSignInSuccess,    // navigation out
    required this.onUnverifiedSignIn, // navigation out
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        userRepository: userRepository,
        onSignInSuccess: onSignInSuccess,
      ),
      child: SignInView(onSignInSuccess: onSignInSuccess),
    );
  }
}
```

> **Rule**: Navigation is **callback-based** (`VoidCallback`). Features never import `go_router` or know about routing. All routes are wired in `lib/routing_table.dart`.

---

## 4. State Management — Cubit + State

### 4.1 State Class

```dart
part of '<feature>_cubit.dart';

class FeatureState extends Equatable {
  const FeatureState({
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.someField = const SomeField.unvalidated(),
    this.error,
  });

  final FormzSubmissionStatus submissionStatus;
  final SomeField someField;
  final dynamic error;

  FeatureState copyWith({...}) { ... }

  @override
  List<Object?> get props => [submissionStatus, someField, error];
}
```

**Rules:**
- Must extend `Equatable` and implement `copyWith` and `props`
- `error` is `dynamic` — caught exceptions go directly into the state
- Uses `FormzSubmissionStatus` (`initial` / `inProgress` / `success` / `failure`)
- Declared as `part of` the cubit file

### 4.2 Cubit Class

```dart
class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit({
    required this.someRepository,
    required this.onSomeNavigation, // nav callback stored in cubit
  }) : super(const FeatureState());

  final SomeRepository someRepository;
  final VoidCallback onSomeNavigation;

  // Validate lazily: only after the field is dirty (blurred/submitted once)
  void onFieldChanged(String? value) { ... }
  void onFieldUnfocused() { /* force validate */ }

  void onSubmit() async {
    // 1. Validate all fields
    // 2. Emit inProgress if valid
    // 3. await repository call
    // 4. Emit success OR emit failure with error in state
  }
}
```

**Rules:**
- Cubit holds **repositories** and **navigation VoidCallbacks**
- Fields validate **lazily**: only switch to `validated` after first blur or submit
- Navigation callbacks are stored as `final` fields and called directly from cubit methods

### 4.3 View / BlocConsumer Pattern

```dart
BlocConsumer<FeatureCubit, FeatureState>(
  listenWhen: (old, current) =>
      old.submissionStatus != current.submissionStatus,
  listener: (context, state) {
    if (state.submissionStatus == FormzSubmissionStatus.success) {
      onSuccess(); return;
    }
    if (state.submissionStatus == FormzSubmissionStatus.failure) {
      showSnackBar(context: context, snackBar: ErrorSnackBar(context: context));
      return;
    }
    if (state.error is SomeSpecificException) { /* specific snackbar */ }
  },
  builder: (context, state) {
    final cubit  = context.read<FeatureCubit>();
    final l10n   = FeatureLocalizations.of(context);
    final theme  = TymerTheme.of(context);
    return Scaffold( ... );
  },
)
```

**Rules:**
- Always use `listenWhen` to narrow listener triggers
- Errors shown via `showSnackBar()` with `ErrorSnackBar` / `SuccessSnackBar` from `component_library`
- Theme via `TymerTheme.of(context)`, margins via `theme.screenMargin`
- Spacing: `VerticalGap.xLarge/large/medium/small()`, `HorizontalGap.*`
- Release focus: wrap root with `GestureDetector(onTap: context.releaseFocus)`

---

## 5. Repository Layer

### Structure:
```
packages/<domain>_repository/lib/src/
├── <domain>_repository.dart      # Main class
├── <domain>_local_storage.dart   # Cache read/write
├── <domain>_secure_storage.dart  # Secure key-value (tokens, sensitive)
├── <domain>_change_notifier.dart
└── mappers/                      # Extension methods RM→DM, RM→CM, CM→DM
```

### Rules:
- Receives `TymerApi remoteApi` and `KeyValueStorage noSqlStorage`
- Calls `remoteApi.<domain>.<method>()` — **never calls Dio directly**
- **Translates** `*TymerException` (API layer) → domain exceptions (from `domain_models`)
- Caching pattern uses `FetchPolicy`: `networkOnly` or `cachePreferably`
- Reactive streams use `BehaviorSubject` from `rxdart`

```dart
// Exception translation pattern
try {
  await remoteApi.auth.someAction();
} catch (error) {
  if (error is SpecificTymerException) throw DomainException();
  rethrow;
}
```

---

## 6. API Layer (`tymer_api`)

### Structure:
```
packages/tymer_api/lib/src/
├── tymer_api.dart      # Facade holding all sub-APIs
├── auth_api.dart
├── url_builder.dart    # All URL construction
└── models/             # Remote Models (*RM) — JSON serializable
```

### Rules:
- Uses **Dio** for all HTTP calls
- JSON keys as `static const` strings at the top of each class
- Remote models named `*RM` (e.g. `UserRM`)
- API-layer exceptions named `*TymerException` (e.g. `InvalidCredentialsTymerException`)
- URL construction only via `UrlBuilder`

```dart
static const _errorJsonKey = 'error';
static const _dataJsonKey  = 'data';

Future<String> someAction({required String param}) async {
  final url = _urlBuilder.buildSomeUrl();
  try {
    final response = await _dio.post(url, data: {'param': param});
    return response.data[_dataJsonKey];
  } on DioException catch (error) {
    // map to *TymerException
    rethrow;
  } catch (_) {
    rethrow;
  }
}
```

---

## 7. Domain Models (`domain_models`)

- Pure Dart — **no Flutter, no Dio, no JSON** dependencies
- Entities: simple classes with `final` fields
- All exceptions in `lib/src/exceptions.dart`, named `*Exception` (no `Tymer` suffix)

```dart
class UserAuthRequiredException implements Exception {}
class OtpRateLimitExceededException implements Exception {
  final int seconds;
  OtpRateLimitExceededException(this.seconds);
}
```

---

## 8. Form Fields (`form_fields`)

- Uses `formz` package — each field extends `FormzInput`
- Validation states: `.unvalidated(value)` / `.validated(value)`
- Submit gate: `Formz.validate([field1, field2])`

---

## 9. Localization (l10n)

- Each feature has `l10n/arb/` with `_en.arb` and `_ar.arb` files
- Access in widgets: `FeatureLocalizations.of(context).someKey`
- Shared strings live in `ComponentLibraryLocalizations`
- **No hardcoded user-facing strings** in Dart files

---

## 10. Naming Conventions

| Item | Convention | Example |
|---|---|---|
| Feature package | `snake_case` | `sign_in`, `top_up_confirmation` |
| Screen widget | `<Feature>Screen` | `SignInScreen` |
| Cubit | `<Feature>Cubit` | `SignInCubit` |
| State | `<Feature>State` | `SignInState` |
| Remote model | `<Name>RM` | `UserRM`, `WalletRM` |
| Cache model | `<Name>CM` | `UserCM`, `SettingsCM` |
| API exception | `<Name>TymerException` | `InvalidCredentialsTymerException` |
| Domain exception | `<Name>Exception` | `InvalidCredentialsException` |
| Mapper methods | extension on RM/CM | `toDomainModel()`, `toCacheModel()` |
| l10n arb files | `<feature>_en.arb` | `sign_in_en.arb` |

---

## 11. Adding a New Feature — Checklist

- [ ] Create `packages/features/<feature_name>/` with `pubspec.yaml` + `l10n.yaml`
- [ ] Add `arb/` files for `en` and `ar`
- [ ] Create `<feature>_state.dart` (Equatable + copyWith + props)
- [ ] Create `<feature>_cubit.dart` (takes repos + nav callbacks, `part`s the state)
- [ ] Create `<feature>_screen.dart` (Screen → BlocProvider → View → BlocConsumer)
- [ ] Create `components/` with sub-widgets and barrel `components.dart`
- [ ] Create barrel `lib/<feature>.dart` (exports screen + l10n only)
- [ ] Wire screen in `lib/routing_table.dart`
- [ ] If new API method needed: add to `*_api.dart` + URL in `url_builder.dart`
- [ ] If new repo method needed: translate exceptions, respect `FetchPolicy`
- [ ] Add new domain exceptions to `domain_models/lib/src/exceptions.dart`
- [ ] Run `make get` after adding the package
