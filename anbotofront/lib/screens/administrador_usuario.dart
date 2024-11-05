import 'package:flutter/material.dart';

class ManageParticipantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
             IconButton(onPressed:(){
              Navigator.restorablePopAndPushNamed(context, "profile");
             }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
            SizedBox(width: 10),
            const Text('Administrar participantes'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( 'Envia una invitacion',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del participiante',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
              ),
              SizedBox(height: 20),
              // Requests list
              Text('Solicitudes para unirse al equipo',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Color y grosor del borde
                  borderRadius: BorderRadius.circular(10), // Radio del borde
                ),
                child: Column(
                  children: List.generate(4, (index) {
                    return ListTile(
                      title: Text('User ${index + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: () {}, child: Text('Aceptar')),
                          TextButton(onPressed: () {}, child: Text('Rechazar')),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              // Remove participant field
              Text(
              'Expulsar a un participante',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del participiante',border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueGrey))),
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
