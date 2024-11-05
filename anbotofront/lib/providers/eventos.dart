import 'dart:convert';
import 'package:anbotofront/models/eventos.dart';
import 'package:anbotofront/providers/globals.dart' as globals;
import 'package:http/http.dart' as http;

class EventosProvider {
  final baseUrl = globals.baseUrl;

  // Método para obtener la lista de eventos
  Future<List<EventModel>> getEventos() async {
    final url = Uri.parse('$baseUrl/api/events');
    print(url);
    final response = await http.get(url);
    print(response.body);
    final List<dynamic> decodedData = json.decode(response.body);
    if (decodedData == null) return [];

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

    // Verificar si la respuesta fue exitosa
    print(response.body);
    print(response.statusCode);
    return response.statusCode == 201; // 201 es el código para "Creado"
  }
}
