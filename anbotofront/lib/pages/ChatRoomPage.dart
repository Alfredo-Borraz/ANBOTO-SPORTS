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
    super.key,
    required this.targetUserName,
    required this.targetUserProfilePic,
    required this.senderId,
    required this.receiverId,
    required this.msg,
  });

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

  String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
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
      backgroundColor: const Color.fromARGB(255, 17, 17, 61),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFDE69),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                              color: isMe ? Colors.white : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentMessage['message'],
                                  style: TextStyle(
                                    color: isMe ? Colors.black : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  formatTime(currentMessage['sentAt']),
                                  style: TextStyle(
                                    color: isMe
                                        ? Colors.black54
                                        : const Color.fromARGB(179, 0, 0, 0),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(221, 255, 255, 255),
                        borderRadius:
                            BorderRadius.circular(30), // Bordes redondeados
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          border: InputBorder.none, // Sin borde
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xffFFDE69),
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: sendMessage,
                      child: const Icon(
                        Icons.send,
                        color: Color(0xff050522),
                      ),
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
