import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavbarItem(icon: 'lib/assets/icons/home.png', label: 'Inicio'),
      _NavbarItem(icon: 'lib/assets/icons/document.png', label: 'Reportes'),
      _NavbarItem(icon: 'lib/assets/icons/flowbite.png', label: 'Reportar', isCenter: true),
      _NavbarItem(icon: 'lib/assets/icons/solarmap.png', label: 'Mapa'),
      _NavbarItem(icon: 'lib/assets/icons/profile.png', label: 'Perfil'),
    ];

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF00C48E),
        border: Border.all(color: Color(0xFF1A1E29), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) {
          final item = items[i];
          final isSelected = selectedIndex == i;

          if (item.isCenter) {
            return Container(
              width: 49,
              height: 49,
              decoration: BoxDecoration(
                color: const Color(0xFF00C48E),
                borderRadius: BorderRadius.circular(20),
                border: const Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: IconButton(
                icon: Image.asset(item.icon, width: 24, height: 24, color: Colors.white),
                onPressed: () => onTap(i),
              ),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset(item.icon, width: 22, height: 22, color: Colors.white),
                onPressed: () => onTap(i),
              ),
              Text(
                item.label,
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w300,
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
class _NavbarItem {
  final String icon;
  final String label;
  final bool isCenter;

  _NavbarItem({
    required this.icon,
    required this.label,
    this.isCenter = false,
  });
}
