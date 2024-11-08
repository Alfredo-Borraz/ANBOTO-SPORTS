import 'dart:convert';

import 'package:http/http.dart' as http;

class TournamentsService {
  final String baseUrl = 'http://127.0.0.1:8000/api/torneos';

  // Obtener todos los torneos
  Future<List<dynamic>> getAllTournaments() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los torneos');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  // Obtener un torneo por ID
  Future<Map<String, dynamic>> getTournamentById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Torneo no encontrado');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  // Crear un nuevo torneo
  Future<void> createTournament(Map<String, dynamic> tournamentData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tournamentData),
      );
      if (response.statusCode != 201) {
        throw Exception('Error al crear el torneo');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  // Actualizar un torneo
  Future<void> updateTournament(
      String id, Map<String, dynamic> tournamentData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tournamentData),
      );
      if (response.statusCode != 200) {
        throw Exception('Error al actualizar el torneo');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  // Eliminar un torneo
  Future<void> deleteTournament(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Error al eliminar el torneo');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
