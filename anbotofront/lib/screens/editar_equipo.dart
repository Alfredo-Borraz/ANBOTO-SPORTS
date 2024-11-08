import 'package:flutter/material.dart';
import 'package:anbotofront/providers/eventos.dart';
import '../providers/providers.dart';
import 'package:anbotofront/models/eventos.dart';
import 'package:provider/provider.dart'; // Importa provider.dart

class EditarEquipoScreen extends StatefulWidget {
  final int eventId;

  const EditarEquipoScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  _EditarEquipoScreenState createState() => _EditarEquipoScreenState();
}

class _EditarEquipoScreenState extends State<EditarEquipoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _informationController = TextEditingController();
  final TextEditingController _participantsCountController =
      TextEditingController();
  final TextEditingController _participantsNamesController =
      TextEditingController();
   EventosProvider eventosProvider =EventosProvider();

  void _updateEvent() async {
    print(widget.eventId);
    final updatedEvent = EventModel(
      id: widget.eventId,
      name: _nameController.text,
      information: _informationController.text,
      participantsCount: int.parse(_participantsCountController.text),
      participants: _participantsNamesController.text.split(','),
      invitationSent: true
    );

    final success = await eventosProvider.updateEvento(updatedEvent);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Evento actualizado exitosamente"),
      ));
      setState(() {
        _nameController.clear();
        _informationController.clear();
        _participantsCountController.clear();
        _participantsNamesController.clear();
        
      });
      Navigator.popAndPushNamed(context, 'menu');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al actualizar el evento"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Equipo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nombre del Evento"),
            ),
            TextField(
              controller: _informationController,
              decoration: InputDecoration(labelText: "Información del Evento"),
            ),
            TextField(
              controller: _participantsCountController,
              decoration:
                  InputDecoration(labelText: "Cantidad de Participantes"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _participantsNamesController,
              decoration: InputDecoration(
                  labelText: "Nombres de Participantes (separados por comas)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateEvent,
              child: Text("Guardar Cambios"),
            ),
          ],
        ),
      ),
    );
  }
}
