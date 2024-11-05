import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Tabla de posiciones',style:TextStyle(color: Colors.white) ,),
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
              style: TextStyle(color: Colors.white),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
