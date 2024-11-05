import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService {
  final String baseUrl = 'http://10.10.0.57:8000/api/users';

  Future<String?> register(
      String username, String email, String phone, String password) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return 'Usuario registrado con éxito';
      } else if (response.statusCode == 400) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Error al registrar usuario';
      } else {
        return 'Error inesperado al registrar usuario';
      }
    } catch (e) {
      return 'Error de red o conexión';
    }
  }

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String token = data['token'];
        await saveToken(token);
        return 'Inicio de sesión exitoso';
      } else if (response.statusCode == 404) {
        return 'Usuario no encontrado';
      } else if (response.statusCode == 401) {
        return 'Contraseña incorrecta';
      } else {
        return 'Error al iniciar sesión';
      }
    } catch (e) {
      return 'Error de red o conexión';
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
