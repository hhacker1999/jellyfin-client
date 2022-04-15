class AppConstants {
  static const String authUrl = "/Users/authenticatebyname";
  static const tmdbApi = "65bca2a7ca87d56ddfe082d039cbf95f";
  static const String tmdbTrendingUrl = "https://api.themoviedb.org/3/trending/all/day";
  static String getViewUrl(String userId) => "/Users/$userId/views";
  static String getResumeItemUrl(String userId) =>
      "/Users/$userId/Items/Resume";
}
