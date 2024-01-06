class ApiLinkManager {
  static const String baseUrl = "https://03f5-1-47-146-51.ngrok-free.app";

  // Auth Endpoints
  static String login() => "$baseUrl/auth/login";
  static String register() => "$baseUrl/auth/register";

  // User Endpoints
  // static String getUserProfile(String userId) => "$baseUrl/users/$userId";
  // static String updateUserProfile(String userId) => "$baseUrl/users/$userId";

  // Other Endpoints
  // static String getPosts() => "$baseUrl/posts";
  // static String createPost() => "$baseUrl/posts";
  // static String getComments(String postId) => "$baseUrl/posts/$postId/comments";

// Add more endpoints as needed

// You can also include API versioning in the URLs if needed
// static String getUserProfile(String userId) => "$baseUrl/v1/users/$userId";
}
