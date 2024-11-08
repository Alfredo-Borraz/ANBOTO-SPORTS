import 'dart:convert';

import 'package:anbotofront/red_social/view/page/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  final titleText = TextEditingController();
  final descripText = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> uploadTournament() async {
    final name = titleText.text;
    final information = descripText.text;

    if (name.isEmpty || information.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/torneos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'information': information,
          'participants_count': 0,
          'participants': [],
          'invitation_sent': false,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Torneo creado exitosamente")),
        );
        titleText.clear();
        descripText.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al crear el torneo")),
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color(0xFF282828),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Nueva Publicación",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 20.0),
          _buildTextField(
            controller: titleText,
            hintText: "Añade un título",
          ),
          const SizedBox(height: 20.0),
          _buildTextField(
            controller: descripText,
            hintText: "Añade una descripción",
            minLines: 4,
            maxLines: 4,
          ),
          const SizedBox(height: 30.0),
          Center(
            child: ElevatedButton(
              onPressed: uploadTournament,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
                shadowColor: Colors.blueAccent.withOpacity(0.3),
              ),
              child: const Text(
                "Publicar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        ),
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}
