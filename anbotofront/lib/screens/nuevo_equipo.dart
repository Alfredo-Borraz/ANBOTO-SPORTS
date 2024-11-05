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
      bool invitationSent = _invitationController.text
          .isNotEmpty; // Aquí puedes cambiar la lógica según tus necesidades

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
        // Manejar el error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el evento')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.restorablePopAndPushNamed(context, "profile");
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            SizedBox(width: 10),
            Text('Crea tu propio equipo'),
          ],
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
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del equipo',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                  ),
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
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _infoController,
                  decoration: InputDecoration(
                    labelText: 'Información sobre el equipo',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                  ),
                ),
                SizedBox(height: 20),
                Text('Número de participantes',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsCountController,
                  decoration: InputDecoration(
                    labelText: 'Número de participantes',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                  ),
                  keyboardType: TextInputType.number,
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
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsController,
                  decoration: InputDecoration(
                    labelText:
                        'Nombre de los participantes (separados por comas)',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                  ),
                ),
                SizedBox(height: 20),
                Text('Envía una invitación',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _invitationController,
                  decoration: InputDecoration(
                    labelText: 'Envía una invitación',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                  ),
                ),
                SizedBox(height: 20),
                // Team photo upload
                Text('Sube una foto de tu equipo',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed:
                        _createEvent, // Llamar al método para crear el evento
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
