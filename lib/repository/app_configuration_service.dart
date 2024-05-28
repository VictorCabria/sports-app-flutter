abstract class AppConfigurationService {
  init(String configurationPath);
  Map<String, dynamic>? getScreenConfiguration(String screen);
  dynamic getConfigurationValue(String screen, String key);
  Iterable<String> get supportedScreens;
  Future<void> setConfiguration(
      Map<String, Map<String, dynamic>?> configuration);
}
