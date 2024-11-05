import 'package:anbotofront/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'tabla': (context) => LeaderboardScreen(),
    'profile': (context) => ProfileInfoScreen(),
    'edit': (context) => EditProfileScreen(),
    'new_team': (context) => CreateTeamScreen (),
    'admin': (context) => ManageParticipantsScreen(),
    'tournament': (context) => TournamentsScreen (),
    
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) =>  ProfileInfoScreen());
  }
}
