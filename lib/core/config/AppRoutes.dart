import 'package:flutter/material.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/iam/presentation/pages/login_page.dart';
import '../../features/iam/presentation/pages/register_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String reports = '/reports';
  static const String report = '/report';
  static const String map = '/map';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    reports: (context) => Scaffold(body: Center(child: Text('Reports'))), // Reemplaza por tu página real
    report: (context) => Scaffold(body: Center(child: Text('Report'))),   // Reemplaza por tu página real
    map: (context) => Scaffold(body: Center(child: Text('Map'))),         // Reemplaza por tu página real
    profile: (context) => Scaffold(body: Center(child: Text('Profile'))), // Reemplaza por tu página real
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
  };
}