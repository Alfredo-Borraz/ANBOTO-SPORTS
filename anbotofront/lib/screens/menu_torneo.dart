import 'package:flutter/material.dart';

class MenuTorneo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menú de Torneo",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey[850],
        padding: EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            MenuOption(
              title: "Perfil de jugador",
              icon: Icons.person,
              color: Colors.blueAccent,
              onTap: () {
                Navigator.pushNamed(context, 'profile');
              },
            ),
            MenuOption(
              title: "Únete a un torneo",
              icon: Icons.sports_esports,
              color: Colors.greenAccent,
              onTap: () {
                Navigator.pushNamed(context, 'tournament');
              },
            ),
            MenuOption(
              title: "Crea tu equipo",
              icon: Icons.group_add,
              color: Colors.purpleAccent,
              onTap: () {
                Navigator.pushNamed(context, 'new_team');
              },
            ),
            MenuOption(
              title: "Administrar participantes",
              icon: Icons.manage_accounts,
              color: Colors.orangeAccent,
              onTap: () {
                Navigator.pushNamed(context, 'admin');
              },
            ),
            MenuOption(
              title: "Estadísticas",
              icon: Icons.bar_chart,
              color: Colors.redAccent,
              onTap: () {
                Navigator.pushNamed(context, 'tabla');
              },
            ),
            MenuOption(
              title: "Chat",
              icon: Icons.chat,
              color: Colors.lightBlueAccent,
              onTap: () {
                Navigator.pushNamed(context, 'chat');
              },
            ),
            MenuOption(
              title: "Red Social",
              icon: Icons.public,
              color: Colors.pinkAccent,
              onTap: () {
                Navigator.pushNamed(context, 'social');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  MenuOption({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[800],
        elevation: 6,
        shadowColor: color.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
