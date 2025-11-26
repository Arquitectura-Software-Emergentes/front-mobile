import 'dart:ui';
import 'package:flutter/material.dart';

class IOSNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const IOSNavbar({
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

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.40),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.25), width: 1),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final isSelected = selectedIndex == i;

              // 🔹 BOTÓN CENTRAL ESTILO iOS FLOAT ACTION
              if (item.isCenter) {
                return GestureDetector(
                  onTap: () => onTap(i),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C48E),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        item.icon,
                        width: 28,
                        height: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }

              // 🔹 ITEMS LATERALES ESTILO IOS
              return GestureDetector(
                onTap: () => onTap(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 26,
                      height: 26,
                      child: Image.asset(
                        item.icon,
                        color: isSelected
                            ? const Color(0xFF00C48E)
                            : Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 3),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                        color: isSelected
                            ? const Color(0xFF00C48E)
                            : Colors.black.withOpacity(0.55),
                      ),
                      child: Text(item.label),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
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
