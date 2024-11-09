import 'package:jwt_decoder/jwt_decoder.dart';

import 'auth_service.dart';

Future<int?> getUserId() async {
  AuthService authService = AuthService();
  String? token = await authService.getToken();

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['id'];
  }

  return null;
}
