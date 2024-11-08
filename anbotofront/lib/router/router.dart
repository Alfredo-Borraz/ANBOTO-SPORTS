import 'package:anbotofront/screens/menu_torneo.dart';
import 'package:anbotofront/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'tabla': (context) => LeaderboardScreen(),
    'profile': (context) => ProfileInfoScreen(),
    'edit': (context) => EditProfileScreen(),
    'new_team': (context) => CreateTeamScreen(),
    'admin': (context) => ManageParticipantsScreen(),
    'tournament': (context) => TournamentsScreen(),
    'menu': (context) => MenuTorneo(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => MenuTorneo());
  }
}
