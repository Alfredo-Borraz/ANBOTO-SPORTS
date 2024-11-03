import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService {
  final String baseUrl = 'http://127.0.0.1:8000/api/auth';

  // Función para registrar un usuario
  Future<String?> register(
      String username, String password, String phone) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      return 'Usuario registrado con éxito';
    } else {
      return 'Error al registrar usuario';
    }
  }

  // Función para iniciar sesión
  Future<String?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return 'OTP enviado, verifica tu teléfono';
    } else {
      return 'Usuario o contraseña incorrectos';
    }
  }

  // Función para verificar el OTP y obtener el token JWT
  Future<bool> verifyOTP(String username, String otp) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String token = data['token'];
      await saveToken(token); // Guarda el token en SharedPreferences
      return true;
    } else {
      return false;
    }
  }

  // Función para guardar el token JWT en SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // Función para obtener el token JWT de SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Función para eliminar el token JWT de SharedPreferences (logout)
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
