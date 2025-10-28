import 'package:flutter/material.dart';
import '../../features/iam/presentation/pages/login_page.dart';
import '../../features/iam/presentation/pages/register_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
  };
}