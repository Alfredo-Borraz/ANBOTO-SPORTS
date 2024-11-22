import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UsuarioService {
  final String baseUrl = 'http://192.168.100.8:8000/api/users';
  IO.Socket? socket;

  void initializeSocketConnection() {
    socket = IO.io('http://192.168.100.8:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('Conectado al servidor de sockets');
    });

    socket!.onDisconnect((_) {
      print('Desconectado del servidor de sockets');
    });
  }

  Future<void> joinChatRoom(int receiverId) async {
    int? senderId = await getUserId();
    if (senderId == null) {
      print("Usuario no autenticado.");
      return;
    }

    socket?.emit('joinRoom', {
      'sender_id': senderId,
      'receiver_id': receiverId,
    });
    print('Usuario $senderId unido a la sala con $receiverId');
  }

  Future<void> sendMessage(int receiverId, String message) async {
    int? senderId = await getUserId();
    if (senderId == null) {
      print("Usuario no autenticado.");
      return;
    }

    socket?.emit('sendMessage', {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
    });
  }

  void listenForMessages(Function(dynamic) onMessageReceived) {
    socket?.on('receiveMessage', (data) {
      onMessageReceived(data);
    });
  }

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
        int userId = data['userId'];

        await saveUserInfo(token, userId);
        initializeSocketConnection();
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

  Future<void> saveUserInfo(String token, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    await prefs.setInt('user_id', userId);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // Cerrar sesión
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_id');
    socket?.disconnect();
  }
}
