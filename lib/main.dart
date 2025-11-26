import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/AppRoutes.dart';
import 'features/iam/presentation/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vnahrflmnhhrixhkrgad.supabase.co', // Reemplaza con tu URL de Supabase
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZuYWhyZmxtbmhocml4aGtyZ2FkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1MTQ0OTQsImV4cCI6MjA3NzA5MDQ5NH0.iFisVYsTPUOyQ0u-6wOOcZm7axQ60BNneTz4NFbte20', // Reemplaza con tu anon key
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lima Urban',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}