class AppConstants {
  static const String authUrl = "/Users/authenticatebyname";
  static String getViewUrl(String userId) => "/Users/$userId/views";
  static String getResumeItemUrl(String userId) => "/Users/$userId/Items/Resume";
}
