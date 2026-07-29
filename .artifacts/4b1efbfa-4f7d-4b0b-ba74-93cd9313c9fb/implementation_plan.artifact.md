# Fix Support for 16 KB Memory Page Sizes

This plan updates the Android build configuration to support 16 KB memory page sizes, a requirement for Android 15 compatibility on devices with larger page sizes. This is primarily achieved by updating the Android Gradle Plugin (AGP), the NDK version, and ensuring native libraries are correctly aligned.

## Proposed Changes

### Android Build Configuration

#### [MODIFY] [settings.gradle](file:///Volumes/Data/tymer/android/settings.gradle)
- Update Android Gradle Plugin (AGP) version from `8.2.1` to `8.5.1`.

#### [MODIFY] [build.gradle](file:///Volumes/Data/tymer/android/app/build.gradle)
- Explicitly set `ndkVersion` to `"27.0.12077973"` (NDK r27) to ensure the linker supports 16 KB alignment.
- Add packaging options to ensure native libraries are not compressed and are correctly aligned.

#### [MODIFY] [gradle.properties](file:///Volumes/Data/tymer/android/gradle.properties)
- Add `android.bundle.enableUncompressedNativeLibs=true` to ensure native libraries in the App Bundle are uncompressed and aligned.

#### [MODIFY] [AndroidManifest.xml](file:///Volumes/Data/tymer/android/app/src/main/AndroidManifest.xml)
- Add `android:extractNativeLibs="false"` to the `<application>` tag to ensure the system can run native libraries directly from the APK/AAB without extraction, which is required for 16 KB alignment support.

## Verification Plan

### Automated Tests
- Run `fvm flutter pub get` to ensure dependencies are resolved.
- Run `fvm flutter build apk --debug` to verify that the project compiles with the updated AGP and NDK versions.

### Manual Verification
- After building, the APK/AAB can be inspected with the APK Analyzer in Android Studio to verify that native libraries (.so files) are 16 KB aligned.
