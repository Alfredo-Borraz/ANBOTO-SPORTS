import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tu perfil'),
          leading: const BackButton(),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Multimedia'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children:  [
                Center(
                  child: Text(
                    "informacion de jugador",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Nombre'),
                  onTap: () {
                    // Acción del botón de editar perfil
                     Navigator.pushReplacementNamed(context, 'edit');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Fecha de nacimiento'),
                ),
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Pronombres'),
                ),
                ListTile(
                  leading: Icon(Icons.wc),
                  title: Text('Género'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Ubicación'),
                ),
                ListTile(
                  leading: Icon(Icons.height),
                  title: Text('Estatura'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'tournament');
                  },
                ),
                Center(
                  child: Text(
                    "Deportes",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Futbol'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'tabla');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.sports_basketball),
                  title: Text('Basketball'),
                  onTap: () => Navigator.pushReplacementNamed(context, 'new_team'),
                ),
                ListTile(
                  leading: Icon(Icons.sports_volleyball),
                  title: Text('Volleyball'),
                  onTap: () => Navigator.pushReplacementNamed(context, 'admin'),
                ),
              ],
            ),
            // Contenido de la pestaña "Multimedia"
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Text(
                    "tovar perez turriate",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      color: Color.fromARGB(255, 91, 89, 89),
                    ),
                    backgroundColor: Color.fromARGB(255, 197, 197, 197),
                    
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Sobre mí",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                const Text('Participando en:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Equipo 1\nEquipo 2',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                                const SizedBox(height: 16),
                const Text('Logros:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Equipo one: 38 puntos\nEquipo two: 20 puntos',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 50,
                  child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 128, 143, 150),
                  ),
                  onPressed: () {
                    // Acción del botón de editar perfil
                  },
                  child: const Text('Editar perfil', style: TextStyle(color: Colors.black),),
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
