import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final Color darkBlue = Color(0xFF003366);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tabla de posiciones',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text(
                    'User ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '${630 - (index * 100)}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Estadísticas de los equipos',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Placeholder(), // Reemplaza con un widget de gráfico real
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuraciones'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
