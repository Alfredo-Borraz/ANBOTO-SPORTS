import 'package:anbotofront/pages/chatRoomPage.dart';
import 'package:chatapp/screens/ChatRoomPage.dart';
import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/SearchPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de chats simulada
  final List<Map<String, String>> chatRooms = [
    {
      'name': 'usuario_1',
      'lastMessage': 'Hola 1',
      'profilePic': 'assets/images/user1.jpg'
    },
    {
      'name': 'usuario_2',
      'lastMessage': 'Hola 2',
      'profilePic': 'assets/images/user2.jpg'
    },
    {
      'name': 'usuario_3',
      'lastMessage': 'Hola 3',
      'profilePic': 'assets/images/user3.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
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
                        targetUserName: chatRoom['name']!,
                        targetUserProfilePic: chatRoom['profilePic']!,
                      );
                    },
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage(chatRoom['profilePic']!),
              ),
              title: Text(chatRoom['name']!),
              subtitle: Text(chatRoom['lastMessage']!),
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
                return SearchPage();
              },
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

class SearchPage {
  const SearchPage();
}

class LoginPage {
  const LoginPage();
}
