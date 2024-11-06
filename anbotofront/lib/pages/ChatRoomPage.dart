import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomPage extends StatefulWidget {
  final String targetUserName;
  final String targetUserProfilePic;
  final int senderId;
  final int receiverId;
  final List<dynamic> msg;

  const ChatRoomPage({
    Key? key,
    required this.targetUserName,
    required this.targetUserProfilePic,
    required this.senderId,
    required this.receiverId,
    required this.msg,
  }) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();
  late List<Map<String, dynamic>> messages;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    messages = widget.msg
        .map((message) => {
              'message': message['message'],
              'isMe': message['sender_id'] == widget.senderId,
              'sentAt': DateTime.parse(message['sent_at']),
            })
        .toList();

    messages.sort((a, b) => a['sentAt'].compareTo(b['sentAt']));
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io('http://192.168.100.8:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.emit('joinRoom', {
      'sender_id': widget.senderId,
      'receiver_id': widget.receiverId,
    });

    socket.on('receiveMessage', (data) {
      setState(() {
        messages.add({
          'message': data['message'],
          'isMe': data['sender_id'] == widget.senderId,
          'sentAt': DateTime.parse(data['sent_at']),
        });

        messages.sort((a, b) => a['sentAt'].compareTo(b['sentAt']));
      });
    });
  }

  void sendMessage() {
    String msg = messageController.text.trim();
    if (msg.isNotEmpty) {
      socket.emit('sendMessage', {
        'sender_id': widget.senderId,
        'receiver_id': widget.receiverId,
        'message': msg,
      });

      messageController.clear();
      log("Message Sent!");
    }
  }

  @override
  void dispose() {
    socket.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(widget.targetUserProfilePic),
            ),
            const SizedBox(width: 10),
            Text(widget.targetUserName),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var currentMessage = messages[index];
                    bool isMe = currentMessage['isMe'];

                    return Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              currentMessage['message'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter message",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
