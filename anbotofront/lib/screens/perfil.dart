import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  final Color lightDarkBackground = Color(0xFF2C2C2C);
  final Color accentColor = Color(0xFF1E88E5);
  final Color textFieldColor = Color(0xFF3A3A3A);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: lightDarkBackground,
        appBar: AppBar(
          backgroundColor: lightDarkBackground,
          title: const Text(
            'Tu perfil',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF1E88E5),
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
              children: [
                Center(
                  child: Text(
                    "Información de jugador",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildProfileListTile(context, Icons.person, 'Nombre'),
                _buildProfileListTile(
                    context, Icons.calendar_today, 'Fecha de nacimiento'),
                _buildProfileListTile(
                    context, Icons.person_outline, 'Pronombres'),
                _buildProfileListTile(context, Icons.wc, 'Género'),
                _buildProfileListTile(context, Icons.location_on, 'Ubicación'),
                _buildProfileListTile(context, Icons.height, 'Estatura'),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "Deportes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildProfileListTile(context, Icons.sports_soccer, 'Fútbol'),
                _buildProfileListTile(
                    context, Icons.sports_basketball, 'Baloncesto'),
                _buildProfileListTile(
                    context, Icons.sports_volleyball, 'Voleibol'),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Text(
                    "Tovar Pérez Turriate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                _buildProfileTextField(context, 'Descripción sobre ti'),
                SizedBox(height: 16),
                Text(
                  'Participando en:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildProfileTextField(context, 'Equipo 1\nEquipo 2'),
                SizedBox(height: 16),
                Text(
                  'Logros:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildProfileTextField(
                    context, 'Equipo one: 38 puntos\nEquipo two: 20 puntos'),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'edit');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
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

  Widget _buildProfileListTile(
      BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: accentColor),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      tileColor: textFieldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildProfileTextField(BuildContext context, String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        filled: true,
        fillColor: textFieldColor,
      ),
      style: TextStyle(color: Colors.white),
      maxLines: labelText.contains('\n') ? 2 : 4,
    );
  }
}
