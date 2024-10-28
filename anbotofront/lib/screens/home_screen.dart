import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido a Chat App'),
      ),
      body: Center(
        child: CustomButton(
          text: 'Ingresar al Chat',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
        ),
      ),
    );
  }
}
