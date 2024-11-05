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
  List<dynamic> chatRooms = [];

  @override
  void initState() {
    super.initState();
    fetchUserChats();
  }

  Future<void> fetchUserChats() async {
    String? token = await AuthService().getToken();
    if (token == null) {
      print("Usuario no autenticado.");
      return;
    }

    final url = Uri.parse('http://192.168.100.8:8000/api/chats/user-chats');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        chatRooms = json.decode(response.body);
      });
    } else {
      print("Error al obtener los chats del usuario");
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
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            final chatRoom = chatRooms[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatRoomPage(
                        targetUserName: chatRoom['name'],
                        targetUserProfilePic: chatRoom['profilePic'] ??
                            'assets/images/default_avatar.png',
                        senderId: chatRoom['chatUserId'],
                        receiverId: chatRoom['chatUserId'],
                      );
                    },
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chatRoom['profilePic'] ??
                    'assets/images/default_avatar.png'),
              ),
              title: Text(chatRoom['name']),
              subtitle: Text(chatRoom['lastMessage']),
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
