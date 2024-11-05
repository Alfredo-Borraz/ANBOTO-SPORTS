import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [ IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, "profile"); 
        }, icon: Icon(Icons.arrow_back_ios_new_rounded)),Text("Editar perfil")],)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholders
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width < 600 ? 3 : 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 20),
              const Text("Sobre mí (Editar)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
              const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              SizedBox(height: 20),
              // Teams list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Equipos en los que participas'),
                 const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Equipo 1\nEquipo 2',
                  ),
                  maxLines: 2,
                ),
                ],
              ),
              // Submit button
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Realizar cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
