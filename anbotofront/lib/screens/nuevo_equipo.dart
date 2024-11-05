import 'package:flutter/material.dart';

class CreateTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.restorablePopAndPushNamed(context, "profile");
            }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
            SizedBox(width: 10),
            Text('Crea tu propio equipo'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Crea tu propio equipo',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del equipo',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
              ),
              SizedBox(height: 20),
              Text('Información sobre el equipo',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Información sobre el equipo',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
              ),
              SizedBox(height: 20),
              Text('Número de participantes',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Número de participantes',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text('Nombre de los participantes',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre de los participantes',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
              ),
              SizedBox(height: 20),
              Text('Envía una invitación',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Envía una invitación',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
              ),
              SizedBox(height: 20),
              // Team photo upload
              Text('Sube una foto de tu equipo',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Icon(Icons.add),
              ),
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
