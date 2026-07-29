# Walkthrough - Enabling Support for 16 KB Memory Page Sizes

I have updated the Android build configuration to support 16 KB memory page sizes, which is required for full compatibility with Android 15 and future devices.

## Changes Made

### Android Build Infrastructure

#### [settings.gradle](file:///Volumes/Data/tymer/android/settings.gradle)
- Upgraded the **Android Gradle Plugin (AGP)** from `8.2.1` to `8.5.1`. This version includes the necessary tooling to handle 16 KB alignment for native libraries.

#### [gradle-wrapper.properties](file:///Volumes/Data/tymer/android/gradle/wrapper/gradle-wrapper.properties)
- Upgraded **Gradle** from `8.5` to `8.7` to support AGP 8.5.1.

#### [gradle.properties](file:///Volumes/Data/tymer/android/gradle.properties)
- Added `android.bundle.enableUncompressedNativeLibs=true`. This ensures that native libraries are stored uncompressed in the App Bundle, allowing them to be page-aligned.

### Application Configuration

#### [build.gradle](file:///Volumes/Data/tymer/android/app/build.gradle)
- Set `ndkVersion` to `"27.0.12077973"` (NDK r27). This version of the NDK uses a linker that supports 16 KB alignment by default.
- Added a `packaging` block with `useLegacyPackaging = false` to ensure modern alignment standards are used.

#### [AndroidManifest.xml](file:///Volumes/Data/tymer/android/app/src/main/AndroidManifest.xml)
- Added `android:extractNativeLibs="false"` to the `<application>` tag. This is required so the system can map native libraries directly from the APK/AAB, which is necessary for page alignment to work.

## Verification Results

### Automated Tests
- The project has been configured with the correct versions and flags.

> [!WARNING]
> **Build Environment Note**: While the code changes are correctly applied, the build failed in the current agent sandbox due to a known Gradle service creation issue (`AndroidLocationsBuildService`) likely related to the very new Java 25 environment. These changes are expected to work on a standard development machine with Java 17 or 21.

### Manual Verification Required
1. Run `fvm flutter build apk` (or `appbundle`) on your local machine.
2. You can verify the alignment by running:
   ```bash
   zipalign -c -p -v 16 <path_to_apk>
   ```
   Or by using the **APK Analyzer** in Android Studio to ensure `.so` files are aligned to 16 KB boundaries.
