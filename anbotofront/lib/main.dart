/*import 'package:anbotofront/views/welcome_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeView(),
    );
  }
}*/

import 'package:anbotofront/torneos/router/router.dart';
import 'package:anbotofront/views/welcome_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'anbotofront',
      // Configuramos `WelcomeView` como la pantalla de inicio
      initialRoute: 'welcome',
      routes: {
        // Definimos la ruta inicial
        'welcome': (context) => const WelcomeView(),
        // Incluimos las rutas del archivo AppRoutes
        ...AppRoutes.routes,
      },
      // Mantenemos onGenerateRoute para rutas no encontradas
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}
