import 'package:flutter/material.dart';

class TournamentsScreen extends StatelessWidget {
  const TournamentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos disponibles'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => FiltersModal(),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildCategory('Futbol', ['Torneo soccer 1', 'Torneo soccer 2'], ['10/15', '15/15']),
                  buildCategory('Basketball', ['Torneo Basket 1', 'Torneo Basket 2'], ['18/20', '20/20']),
                  buildCategory('Volleyball', ['Torneo Volley 1', 'Torneo Volley 2'], ['8/8', '6/8']),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildCategory(String title, List<String> tournaments, List<String> slots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...List.generate(tournaments.length, (index) {
          return Card(
            child: ListTile(
              title: Text(tournaments[index]),
              trailing: Text(slots[index]),
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
  
}
class FiltersModal extends StatelessWidget {
  const FiltersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filtros',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          const Text('Tipo de torneo'),
          RadioListTile(
            title: const Text('Futbol'),
            value: 'Futbol',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text('Basketball'),
            value: 'Basketball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text('Volleyball'),
            value: 'Volleyball',
            groupValue: 'Futbol',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

