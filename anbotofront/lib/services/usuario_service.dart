import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UsuarioService {
  final String baseUrl = 'http://192.168.100.8:8000/api/users';
  IO.Socket? socket;

  // Inicializa y conecta el socket
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

  // Únete a una sala de chat
  void joinChatRoom(String senderId, String receiverId) {
    final room = [senderId, receiverId].toList()..sort();
    socket
        ?.emit('joinRoom', {'sender_id': senderId, 'receiver_id': receiverId});
    print('Usuario $senderId unido a la sala $room');
  }

  // Enviar un mensaje
  void sendMessage(String senderId, String receiverId, String message) {
    socket?.emit('sendMessage', {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
    });
  }

  // Escuchar mensajes entrantes
  void listenForMessages(Function(dynamic) onMessageReceived) {
    socket?.on('receiveMessage', (data) {
      onMessageReceived(data);
    });
  }

  // Registrar usuario
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

  // Iniciar sesión de usuario
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
        initializeSocketConnection(); // Inicializar conexión de socket después de iniciar sesión
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

  // Guardar token en SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // Obtener token de SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Cerrar sesión
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    socket?.disconnect(); // Desconectar el socket al cerrar sesión
  }
}
