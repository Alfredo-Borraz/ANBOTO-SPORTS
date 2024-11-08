import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomPage extends StatefulWidget {
  final String targetUserName;
  final String targetUserProfilePic;
  final int senderId; // ID del usuario actual
  final int receiverId; // ID del usuario destino

  const ChatRoomPage({
    Key? key,
    required this.targetUserName,
    required this.targetUserProfilePic,
    required this.senderId,
    required this.receiverId,
  }) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = []; // Lista de mensajes con detalles
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    // Configuración de la conexión con Socket.IO
    socket = IO.io('http://127.0.0.1:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Unirse a la sala única entre estos dos usuarios
    socket.emit('joinRoom', {
      'sender_id': widget.senderId,
      'receiver_id': widget.receiverId,
    });

    // Escucha cuando un mensaje es recibido
    socket.on('receiveMessage', (data) {
      setState(() {
        messages.insert(0, {
          'message': data['message'],
          'isMe': data['sender_id'] == widget.senderId,
        });
      });
    });
  }

  void sendMessage() {
    String msg = messageController.text.trim();
    if (msg.isNotEmpty) {
      // Envía el mensaje al servidor
      socket.emit('sendMessage', {
        'sender_id': widget.senderId,
        'receiver_id': widget.receiverId,
        'message': msg,
      });

      setState(() {
        messages.insert(0, {
          'message': msg,
          'isMe': true,
        });
        messageController.clear();
        log("Message Sent!");
      });
    }
  }

  @override
  void dispose() {
    socket.dispose(); // Cierra la conexión cuando se cierra la pantalla
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
            // Chats
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var currentMessage = messages[index];
                    bool isMe = currentMessage['isMe'];

                    return Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
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
