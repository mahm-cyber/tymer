# Walkthrough - Changing Package Name to com.tymer.org

I have successfully updated the package name/bundle identifier to `com.tymer.org` across all supported platforms (Android, iOS, Linux, and macOS).

## Changes Made

### Android

#### [build.gradle](file:///Volumes/Data/tymer/android/app/build.gradle)
- Updated `namespace` to `"com.tymer.org"`.
- Updated `applicationId` to `"com.tymer.org"`.

#### [MainActivity.kt](file:///Volumes/Data/tymer/android/app/src/main/kotlin/com/tymer/org/MainActivity.kt)
- Moved the file from `com/tymer/` to `com/tymer/org/`.
- Updated the package declaration to `package com.tymer.org`.

#### [google-services.json](file:///Volumes/Data/tymer/android/app/google-services.json)
- Updated the `"package_name"` to `"com.tymer.org"`.

### iOS

#### [project.pbxproj](file:///Volumes/Data/tymer/ios/Runner.xcodeproj/project.pbxproj)
- Globally updated `PRODUCT_BUNDLE_IDENTIFIER` from `com.tymer` to `com.tymer.org`.

#### [GoogleService-Info.plist](file:///Volumes/Data/tymer/ios/Runner/GoogleService-Info.plist)
- Updated the bundle ID to `com.tymer.org`.

### Flutter & Desktop

#### [firebase_options.dart](file:///Volumes/Data/tymer/lib/firebase_options.dart)
- Updated `iosBundleId` to `'com.tymer.org'`.

#### [CMakeLists.txt](file:///Volumes/Data/tymer/linux/CMakeLists.txt)
- Updated `APPLICATION_ID` to `"com.tymer.org"`.

#### [AppInfo.xcconfig](file:///Volumes/Data/tymer/macos/Runner/Configs/AppInfo.xcconfig)
- Updated `PRODUCT_BUNDLE_IDENTIFIER` to `com.tymer.org`.

## Verification Results

### Automated Tests
- Ran `fvm flutter pub get` successfully, confirming that the dependency tree is still valid and local configurations have been updated.

> [!IMPORTANT]
> **Action Required**: You must now update your app's package name in the **Firebase Console** for both Android and iOS projects to match `com.tymer.org`. Failure to do so will cause Firebase services (like Auth or Analytics) to stop working in your next build.

> [!WARNING]
> Since the `applicationId` has changed, the Google Play Store will treat this as a **brand new app**. You cannot upload this as an update to an existing app with the old ID.
