class EnvironmentConfig {
  static const APP_NAME = String.fromEnvironment('DART_DEFINES_APP_NAME',
      defaultValue: "Gigi Laundry");
  static const APP_SUFFIX = String.fromEnvironment('DART_DEFINES_APP_SUFFIX');
  static const BASE_URL = String.fromEnvironment('DART_DEFINES_BASE_URL',
      defaultValue: "https://chat-glopr-dev.up.railway.app/api/");
  static const BASE_IMAGE_URL =
      String.fromEnvironment('DART_DEFINES_BASE_IMAGE_URL', defaultValue: "");
}
