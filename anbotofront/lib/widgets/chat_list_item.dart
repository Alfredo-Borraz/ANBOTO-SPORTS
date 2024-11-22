// widgets/chat_list_item.dart

import 'package:flutter/material.dart';

import '../models/user.dart';

class ChatListItem extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const ChatListItem({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(user.imageUrl),
      ),
      title: Text(user.name),
      subtitle: const Text('Último mensaje...'), // Puedes personalizar esto
      onTap: onTap,
    );
  }
}
