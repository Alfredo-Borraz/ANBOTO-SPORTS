import 'dart:convert';

import 'package:anbotofront/helper/auth_utils.dart';
import 'package:anbotofront/pages/ChatRoomPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> searchUsers() async {
    final query = searchController.text.trim();
    if (query.isNotEmpty) {
      final url =
          Uri.parse('http://192.168.100.8:8000/api/users/search?query=$query');
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
    int? senderId = await getUserId();

    if (senderId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChatRoomPage(
              targetUserName: user['username'],
              targetUserProfilePic: 'assets/images/profile_img1.png',
              senderId: senderId,
              receiverId: user['id'],
              msg: [],
            );
          },
        ),
      );
    } else {
      print("Usuario no autenticado.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050522),
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: const Color(0xffFFDE69),
        elevation: 0,
        centerTitle: true,
        foregroundColor: const Color(0xff050522),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Email Address or Username",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.secondary),
                      onPressed: searchUsers,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final user = searchResults[index];
                          return GestureDetector(
                            onTap: () => navigateToChatRoom(user),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/profile_img1.png'),
                                    backgroundColor: Colors.grey,
                                    radius: 25,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['username'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          user['email'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
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
