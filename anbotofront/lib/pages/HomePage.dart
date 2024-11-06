import 'dart:convert';

import 'package:anbotofront/helper/auth_service.dart';
import 'package:anbotofront/pages/ChatRoomPage.dart';
import 'package:anbotofront/pages/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> chatConversations = [];

  @override
  void initState() {
    super.initState();
    fetchUserConversations();
  }

  Future<void> fetchUserConversations() async {
    String? token = await AuthService().getToken();
    if (token == null) {
      print("Usuario no autenticado.");
      return;
    }

    final url =
        Uri.parse('http://192.168.100.8:8000/api/chat/socket/conversacion');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        chatConversations = json.decode(response.body);
      });
    } else {
      print("Error al obtener las conversaciones previas del usuario");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat App"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: chatConversations.length,
          itemBuilder: (context, index) {
            final conversation = chatConversations[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatRoomPage(
                        targetUserName: conversation['name'],
                        targetUserProfilePic: 'assets/images/user1.jpg',
                        senderId: conversation['chatUserId'],
                        receiverId: conversation['chatUserId'],
                      );
                    },
                  ),
                );
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user1.jpg'),
              ),
              title: Text(conversation['name']),
              subtitle: Text(conversation['lastMessage']),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SearchPage();
              },
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
