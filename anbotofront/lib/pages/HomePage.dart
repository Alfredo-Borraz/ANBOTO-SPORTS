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
  int? currentUserId;

  @override
  void initState() {
    super.initState();
    initializeUserId();
  }

  Future<void> initializeUserId() async {
    currentUserId = await AuthService().getUserId();
    if (currentUserId == null) {
      print("Usuario no autenticado.");
    } else {
      fetchUserConversations();
    }
  }

  Future<void> fetchUserConversations() async {
    String? token = await AuthService().getToken();
    if (token == null) {
      print("Usuario no autenticado.");
      return;
    }

    final url =
        Uri.parse('http://192.168.100.8:8000/api/chat/sockets/conversaciones');
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

  Future<List<dynamic>> fetchChatMessages(int chatUserId) async {
    String? token = await AuthService().getToken();
    if (token == null) {
      print("Usuario no autenticado.");
      return [];
    }

    final url = Uri.parse(
        'http://192.168.100.8:8000/api/chat/sockets/messages?userId=${currentUserId}&chatUserId=${chatUserId}');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Error al obtener los mensajes entre usuarios");
      return [];
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
              onTap: () async {
                List<dynamic> messages =
                    await fetchChatMessages(conversation['chatUserId']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatRoomPage(
                        targetUserName: conversation['name'],
                        targetUserProfilePic: 'assets/images/user1.jpg',
                        senderId: currentUserId!,
                        receiverId: conversation['chatUserId'],
                        msg: messages,
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
