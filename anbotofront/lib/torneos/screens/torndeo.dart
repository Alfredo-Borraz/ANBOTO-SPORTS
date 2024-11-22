import 'package:anbotofront/torneos/models/eventos.dart';
import 'package:anbotofront/torneos/providers/eventos.dart';
import 'package:flutter/material.dart';

import 'editar_equipo.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({Key? key}) : super(key: key);

  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  late EventosProvider eventosProvider;
  List<EventModel> eventsos = [];

  @override
  void initState() {
    super.initState();
    eventosProvider = EventosProvider();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    await eventosProvider.getEventos();
    setState(() {
      eventsos = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Torneos disponibles',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, 'menu'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Buscar torneos',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.grey[900],
                      context: context,
                      builder: (context) => FiltersModal(),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: buildCategories(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view, color: Colors.white),
          ],
        ),
      ),
    );
  }

  List<Widget> buildCategories() {
    Map<String, List<EventModel>> categorizedEvents = {
      'Futbol': [],
      'Basketball': [],
      'Volleyball': [],
      'Otros': [],
    };

    for (var event in eventsos) {
      String category;
      if (event.name!.toLowerCase().contains('futbol')) {
        category = 'Futbol';
      } else if (event.name!.toLowerCase().contains('basket')) {
        category = 'Basketball';
      } else if (event.name!.toLowerCase().contains('volley')) {
        category = 'Volleyball';
      } else {
        category = 'Otros';
      }
      categorizedEvents[category]!.add(event);
    }

    return categorizedEvents.entries.map((entry) {
      String categoryName = entry.key;
      List<EventModel> eventsInCategory = entry.value;

      return buildCategory(categoryName, eventsInCategory);
    }).toList();
  }

  Widget buildCategory(String title, List<EventModel> tournaments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        ...List.generate(tournaments.length, (index) {
          return Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                tournaments[index].name!,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarEquipoScreen(
                            eventId: tournaments[index].id!,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      eventosProvider.deleteEvento(tournaments[index].id!).then(
                        (success) {
                          if (success) {
                            fetchEvents();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Torneo eliminado correctamente'
                                    : 'Error al eliminar torneo',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FiltersModal extends StatelessWidget {
  FiltersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filtros',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              labelText: 'Ubicación',
              labelStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              labelText: 'Número de integrantes',
              labelStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Tipo de torneo', style: TextStyle(color: Colors.white)),
          RadioListTile(
            title: const Text('Futbol', style: TextStyle(color: Colors.white)),
            value: 'Futbol',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title:
                const Text('Basketball', style: TextStyle(color: Colors.white)),
            value: 'Basketball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title:
                const Text('Volleyball', style: TextStyle(color: Colors.white)),
            value: 'Volleyball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
