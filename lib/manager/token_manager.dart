// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class TokenManager {
//   static const String _tokenKey = 'auth_token';
//
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//
//   Future<void> storeToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
//   }
//
//   Future<String?> getToken() async {
//     return await _storage.read(key: _tokenKey);
//   }
//
//   Future<void> deleteToken() async {
//     await _storage.delete(key: _tokenKey);
//   }
// }
//
//
//
//
// TokenManager tokenManager = TokenManager();
//
// // Storing the token
// String authToken = "your_token_here";
// await tokenManager.storeToken(authToken);
//
// // Retrieving the token
// String? storedToken = await tokenManager.getToken();
//
// if (storedToken != null) {
// // Use the storedToken for authentication
// } else {
// // Token not available, user needs to log in or authenticate
// }
