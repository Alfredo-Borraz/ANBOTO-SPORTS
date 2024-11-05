import 'package:flutter/material.dart';
import 'package:anbotofront/providers/eventos.dart';
import 'package:anbotofront/models/eventos.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({Key? key}) : super(key: key);

  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  late EventosProvider eventosProvider;
  List<EventModel> eventsos = [];
  final Color darkBlue = Color(0xFF003366);

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
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text('Torneos disponibles',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, 'profile'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar torneos',
                prefixIcon: Icon(Icons.search, color: darkBlue),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: darkBlue),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => FiltersModal(),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: darkBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkBlue, width: 2),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuraciones'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
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
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: darkBlue),
        ),
        const SizedBox(height: 8),
        ...List.generate(tournaments.length, (index) {
          return Card(
            child: ListTile(
              title: Text(tournaments[index].name!),
              trailing: Text(
                '${tournaments[index].participantsCount}/${tournaments[index].participants!.length}',
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
  final Color darkBlue = Color(0xFF003366);

  FiltersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filtros',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: darkBlue),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Ubicación',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Número de integrantes',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Tipo de torneo', style: TextStyle(color: darkBlue)),
          RadioListTile(
            title: Text('Futbol', style: TextStyle(color: darkBlue)),
            value: 'Futbol',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: Text('Basketball', style: TextStyle(color: darkBlue)),
            value: 'Basketball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: Text('Volleyball', style: TextStyle(color: darkBlue)),
            value: 'Volleyball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
