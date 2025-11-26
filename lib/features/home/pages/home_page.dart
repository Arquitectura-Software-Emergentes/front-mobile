import 'package:flutter/material.dart';
// import '../../../core/config/AppRoutes.dart';
import '../../../shared/IOSnavbar.dart';
import '../../reports/presentation/pages/report_page.dart';
import '../../../shared/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavbarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSectionWidget(int index) {
    switch (index) {
      case 0:
        return Center(child: Text('Inicio'));
      case 1:
        return const ReportPage();
      case 2:
        return Center(child: Text('Reportar'));
      case 3:
        return Center(child: Text('Mapa'));
      case 4:
        return Center(child: Text('Perfil'));
      default:
        return Center(child: Text('Inicio'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSectionWidget(_selectedIndex),
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedIndex,
        onTap: _onNavbarTap,
      ),
    );
  }
}