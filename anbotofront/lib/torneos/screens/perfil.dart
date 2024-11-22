import 'dart:convert';

import 'package:anbotofront/helper/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final Color lightDarkBackground = const Color(0xFF2C2C2C);
  final Color accentColor = const Color(0xFF1E88E5);
  final Color textFieldColor = const Color(0xFF3A3A3A);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> updateUserProfile() async {
    final String name = nameController.text;
    final String phone = phoneController.text;

    // Obtén el userId del usuario logueado
    final int? userId = await _authService.getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Usuario no autenticado")),
      );
      return;
    }

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('http://192.168.100.8:8000/api/users/update/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': name,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario actualizado exitosamente")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al actualizar usuario")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error de conexión: $e")),
      );
    }
  }

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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF1E88E5),
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Actualizar Perfil'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Center(
                  child: Text(
                    "Información de jugador",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildProfileListTile(context, Icons.person, 'Nombre'),
                _buildProfileListTile(
                    context, Icons.calendar_today, 'Fecha de nacimiento'),
                _buildProfileListTile(
                    context, Icons.person_outline, 'Pronombres'),
                _buildProfileListTile(context, Icons.wc, 'Género'),
                _buildProfileListTile(context, Icons.location_on, 'Ubicación'),
                _buildProfileListTile(context, Icons.height, 'Estatura'),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Deportes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildProfileListTile(context, Icons.sports_soccer, 'Fútbol'),
                _buildProfileListTile(
                    context, Icons.sports_basketball, 'Baloncesto'),
                _buildProfileListTile(
                    context, Icons.sports_volleyball, 'Voleibol'),
              ],
            ),
            // Contenido de la pestaña "Actualizar Perfil"
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Sobre mí",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildProfileTextField(context, 'Descripción sobre ti'),
                const SizedBox(height: 16),
                const Text(
                  'Participando en:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProfileTextField(context, 'Equipo 1\nEquipo 2'),
                const SizedBox(height: 16),
                const Text(
                  'Logros:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProfileTextField(
                    context, 'Equipo one: 38 puntos\nEquipo two: 20 puntos'),
                const SizedBox(height: 16),
                const Text(
                  'Actualizar Información:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildEditableTextField(
                  controller: nameController,
                  labelText: 'Nombre',
                ),
                const SizedBox(height: 16),
                _buildEditableTextField(
                  controller: phoneController,
                  labelText: 'Teléfono',
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: updateUserProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Guardar cambios',
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
        style: const TextStyle(color: Colors.white),
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
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        filled: true,
        fillColor: textFieldColor,
      ),
      style: const TextStyle(color: Colors.white),
      maxLines: labelText.contains('\n') ? 2 : 4,
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        filled: true,
        fillColor: textFieldColor,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
