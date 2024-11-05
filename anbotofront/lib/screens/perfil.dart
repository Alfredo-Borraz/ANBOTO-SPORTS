import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  final Color darkBlue = Color(0xFF003366); // Azul oscuro personalizado

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlue,
          title: const Text('Tu perfil', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Multimedia'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contenido de la pestaña "Perfil"
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Text(
                    "Información de jugador",
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.person, color: darkBlue),
                  title: Text('Nombre'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'edit');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today, color: darkBlue),
                  title: Text('Fecha de nacimiento'),
                ),
                ListTile(
                  leading: Icon(Icons.person_outline, color: darkBlue),
                  title: Text('Pronombres'),
                ),
                ListTile(
                  leading: Icon(Icons.wc, color: darkBlue),
                  title: Text('Género'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: darkBlue),
                  title: Text('Ubicación'),
                ),
                ListTile(
                  leading: Icon(Icons.height, color: darkBlue),
                  title: Text('Estatura'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'tournament');
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "Deportes",
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.sports_soccer, color: darkBlue),
                  title: Text('Fútbol'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'tabla');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.sports_basketball, color: darkBlue),
                  title: Text('Baloncesto'),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, 'new_team'),
                ),
                ListTile(
                  leading: Icon(Icons.sports_volleyball, color: darkBlue),
                  title: Text('Voleibol'),
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
                    "Tovar Pérez Turriate",
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFC5C5C5),
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      color: Color(0xFF5B5959),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Sobre mí",
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                Text(
                  'Participando en:',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                    labelText: 'Equipo 1\nEquipo 2',
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                Text(
                  'Logros:',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkBlue, width: 2),
                    ),
                    labelText: 'Equipo one: 38 puntos\nEquipo two: 20 puntos',
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción del botón de editar perfil
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Editar perfil',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
