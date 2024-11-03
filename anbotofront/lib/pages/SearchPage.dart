import 'dart:convert';

import 'package:anbotofront/helper/auth_utils.dart'; // Importa auth_utils para obtener el userId
import 'package:anbotofront/pages/ChatRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults =
      []; // Lista para almacenar los resultados de la búsqueda

  Future<void> searchUsers() async {
    final query = searchController.text.trim();
    if (query.isNotEmpty) {
      final url =
          Uri.parse('http://127.0.0.1:8000/api/users/search?query=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
        });
      } else {
        print("Error al buscar usuarios");
      }
    }
  }

  Future<void> navigateToChatRoom(Map<String, dynamic> user) async {
    int? senderId = await getUserId(); // Obtiene el ID del usuario actual

    if (senderId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChatRoomPage(
              targetUserName: user['username'],
              targetUserProfilePic:
                  user['profile_pic'] ?? 'assets/images/default_avatar.png',
              senderId: senderId,
              receiverId: user['id'],
            );
          },
        ),
      );
    } else {
      print("Usuario no autenticado.");
      // Puedes mostrar un mensaje de error o redirigir al usuario a la pantalla de inicio de sesión
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: "Email Address or Username"),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: searchUsers, // Llama a la función de búsqueda
                color: Theme.of(context).colorScheme.secondary,
                child: const Text("Search"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final user = searchResults[index];
                    return ListTile(
                      onTap: () => navigateToChatRoom(
                          user), // Navega a ChatRoom con el ID del usuario actual
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user['profile_pic'] ??
                            'assets/images/default_avatar.png'),
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(user['username']),
                      subtitle: Text(user['email']),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
