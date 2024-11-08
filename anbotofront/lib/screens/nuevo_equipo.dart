import 'package:anbotofront/models/eventos.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Asegúrate de importar esto para usar json
import 'package:http/http.dart' as http;

import '../providers/providers.dart'; // Asegúrate de tener esta importación para realizar solicitudes HTTP
import 'package:anbotofront/models/eventos.dart'; // Import the correct EventModel

class CreateTeamScreen extends StatefulWidget {
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  late EventosProvider eventosProvider;
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _participantsCountController =
      TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _invitationController = TextEditingController();

  void initState() {
    super.initState();
    eventosProvider = EventosProvider(); // Inicializar el provider aquí
  }

  void _createEvent() async {
    if (_formKey.currentState!.validate()) {
      String teamName = _teamNameController.text;
      String information = _infoController.text;
      int participantsCount = int.parse(_participantsCountController.text);
      List<String> participants = _participantsController.text
          .split(','); // Suponiendo que los nombres estén separados por comas
      bool invitationSent = _invitationController.text.isNotEmpty;

      EventModel newEvent = EventModel(
        name: teamName,
        information: information,
        participantsCount: participantsCount,
        participants: participants,
        invitationSent: invitationSent,
      );

      bool success = await eventosProvider.createEvento(
          newEvent as EventModel); // Llamar al método de creación del evento

      if (success) {
        // Mostrar un mensaje de éxito o navegar a otra pantalla
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evento creado exitosamente')),
        );
        // Reiniciar campos después de crear el evento, si es necesario
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el evento')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          'Crea tu propio equipo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Crea tu propio equipo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del equipo',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre para el equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Información sobre el equipo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _infoController,
                  decoration: InputDecoration(
                    labelText: 'Información sobre el equipo',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text('Número de participantes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsCountController,
                  decoration: InputDecoration(
                    labelText: 'Número de participantes',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el número de participantes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Nombre de los participantes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsController,
                  decoration: InputDecoration(
                    labelText:
                        'Nombre de los participantes (separados por comas)',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text('Envía una invitación',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _invitationController,
                  decoration: InputDecoration(
                    labelText: 'Envía una invitación',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text('Sube una foto de tu equipo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[700],
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _createEvent,
                    child: Text('Realizar cambios'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
