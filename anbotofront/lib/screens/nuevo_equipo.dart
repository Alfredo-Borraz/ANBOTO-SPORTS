import 'package:anbotofront/models/eventos.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/providers.dart';

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

  final Color darkBlue = Color(0xFF003366);

  @override
  void initState() {
    super.initState();
    eventosProvider = EventosProvider();
  }

  void _createEvent() async {
    if (_formKey.currentState!.validate()) {
      // Código de creación del evento
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.restorablePopAndPushNamed(context, "profile");
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text('Crea tu propio equipo',
                style: TextStyle(color: Colors.white)),
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
                Text(
                  'Crea tu propio equipo',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del equipo',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBlue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre para el equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Información sobre el equipo',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _infoController,
                  decoration: InputDecoration(
                    labelText: 'Información sobre el equipo',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBlue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Número de participantes',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsCountController,
                  decoration: InputDecoration(
                    labelText: 'Número de participantes',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBlue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
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
                Text(
                  'Nombre de los participantes',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _participantsController,
                  decoration: InputDecoration(
                    labelText:
                        'Nombre de los participantes (separados por comas)',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBlue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Envía una invitación',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _invitationController,
                  decoration: InputDecoration(
                    labelText: 'Envía una invitación',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBlue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sube una foto de tu equipo',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
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
                    onPressed: _createEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Realizar cambios',
                      style: TextStyle(color: Colors.white),
                    ),
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
