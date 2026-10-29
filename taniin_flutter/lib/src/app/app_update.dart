/// Build number baked in by the Android APK workflow (`--dart-define`);
/// 0 on web and local builds.
const int appBuild = int.fromEnvironment('TANIIN_BUILD');
