import 'dart:convert';
import 'package:anbotofront/models/eventos.dart';
import 'package:anbotofront/providers/globals.dart' as globals;
import 'package:http/http.dart' as http;

class EventosProvider {
  final baseUrl = globals.baseUrl;

  // Método para obtener la lista de eventos
  Future<List<EventModel>> getEventos() async {
    final url = Uri.parse('$baseUrl/api/events');
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    if (decodedData == null) return [];
    events.clear();
    decodedData.forEach((evento) {
      final eventoTemp = EventModel.fromJson(evento);
      events.add(eventoTemp);
    });

    return events;
  }

  // Método para crear un nuevo evento
  Future<bool> createEvento(EventModel nuevoEvento) async {
    final url = Uri.parse('$baseUrl/api/events');
    print(nuevoEvento.participants);

    // Convertir el evento a JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type':
            'application/json', // Establecer el tipo de contenido a JSON
      },
      body: json.encode({
        'name': nuevoEvento.name,
        'information': nuevoEvento.information,
        'participants_count': nuevoEvento.participantsCount,
        'participants': nuevoEvento.participants, // Convertir a string
        'invitation_sent':
            nuevoEvento.invitationSent! ? 1 : 0, // Usar 1 o 0 para booleano
      }),
    );
    return response.statusCode == 201; // 201 es el código para "Creado"
  }
  Future<bool> updateEvento(EventModel evento) async {
    final url = Uri.parse('$baseUrl/api/events/${evento.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': evento.name,
        'information': evento.information,
        'participants_count': evento.participantsCount,
        'participants': evento.participants,
        'invitation_sent': evento.invitationSent,
      }),
    );
    return response.statusCode == 200; // 200 es el código para "OK"
  }
  Future<bool> deleteEvento(int id) async {
    final url = Uri.parse('$baseUrl/api/events/$id');
    final response = await http.delete(url);
    print(response.body);
    return response.statusCode == 200; // 200 es el código para "OK"
  }
}
