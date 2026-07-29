# Change Package Name to com.tymer.org

The goal is to update the Android package name (Application ID and Namespace) from `com.tymer` to `com.tymer.org`. This involves updating Gradle configurations, moving source files, and updating Firebase configurations for consistency.

## User Review Required

> [!IMPORTANT]
> Changing the `applicationId` will change the identity of your app on the Google Play Store. If you have already published the app, this will be treated as a **new app**, and you will not be able to update the existing one.

> [!WARNING]
> Since this project uses Firebase, you **must** update the package name in the Firebase Console and re-download the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files. Manually editing these files in the IDE might not be enough for all Firebase services to function correctly.

## Proposed Changes

### Android Component

#### [MODIFY] [build.gradle](file:///Volumes/Data/tymer/android/app/build.gradle)
- Change `namespace` from `"com.tymer"` to `"com.tymer.org"`.
- Change `applicationId` from `"com.tymer"` to `"com.tymer.org"`.

#### [MODIFY] [MainActivity.kt](file:///Volumes/Data/tymer/android/app/src/main/kotlin/com/tymer/MainActivity.kt)
- Update package declaration to `package com.tymer.org`.
- **Note:** This file will be moved to a new directory structure: `android/app/src/main/kotlin/com/tymer/org/`.

#### [MODIFY] [google-services.json](file:///Volumes/Data/tymer/android/app/google-services.json)
- Update `"package_name"` to `"com.tymer.org"`.

---

### Flutter & Other Platforms (For Consistency)

#### [MODIFY] [firebase_options.dart](file:///Volumes/Data/tymer/lib/firebase_options.dart)
- Update `iosBundleId` to `"com.tymer.org"` (if you plan to change iOS as well).

#### [MODIFY] [project.pbxproj](file:///Volumes/Data/tymer/ios/Runner.xcodeproj/project.pbxproj)
- Update `PRODUCT_BUNDLE_IDENTIFIER` to `"com.tymer.org"`.

#### [MODIFY] [GoogleService-Info.plist](file:///Volumes/Data/tymer/ios/Runner/GoogleService-Info.plist)
- Update `BUNDLE_ID` to `"com.tymer.org"`.

#### [MODIFY] [CMakeLists.txt](file:///Volumes/Data/tymer/linux/CMakeLists.txt)
- Update `APPLICATION_ID` to `"com.tymer.org"`.

#### [MODIFY] [AppInfo.xcconfig](file:///Volumes/Data/tymer/macos/Runner/Configs/AppInfo.xcconfig)
- Update `PRODUCT_BUNDLE_IDENTIFIER` to `"com.tymer.org"`.

## Verification Plan

### Automated Tests
- Run `fvm flutter pub get` to ensure dependencies are still resolved.
- Run `fvm flutter build apk --debug` to verify that the Android project compiles with the new package name.

### Manual Verification
- Verify the package name in the generated APK using `aapt dump badging` or by installing it on a device.
- Check that Firebase still initializes correctly (requires Console updates).
