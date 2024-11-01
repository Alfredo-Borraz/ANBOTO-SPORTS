import 'package:anbotofront/pages/ChatRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

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
                decoration: const InputDecoration(labelText: "Email Address"),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  setState(() {});
                },
                color: Theme.of(context).colorScheme.secondary,
                child: const Text("Search"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ChatRoomPage(
                                targetUserName: "Sample User",
                                targetUserProfilePic: "assets/images/user1.jpg",
                              );
                            },
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user1.jpg"),
                        backgroundColor: Colors.grey,
                      ),
                      title: const Text("Sample User"),
                      subtitle: const Text("sampleuser@example.com"),
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
