import 'package:flutter/material.dart';

import '../../../../core/config/AppRoutes.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _login() async {
    try {
      final datasource = AuthRemoteDatasource();
      // PARA EL DATABASE CON SUPABASE
      //final repository = AuthRepositoryImpl(datasource);
      //final usecase = LoginUsecase(repository);
      final repository = AuthRepositoryMock();
      final usecase = LoginUsecase(repository);

      final user = await usecase(
        _emailController.text,
        _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double boxWidth = size.width * 0.95;
    final double boxHeight = size.height * 0.90;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background_login.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main white box
          Center(
            child: Container(
              width: boxWidth > 363 ? 363 : boxWidth,
              height: boxHeight > 613 ? 613 : boxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(37),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.04),
                    // Logo
                    SizedBox(
                      width: 85,
                      height: 85,
                      child: Image.asset(
                        'lib/assets/images/logo_limaurban.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Título
                    SizedBox(
                      width: 238,
                      height: 60,
                      child: Center(
                        child: Text(
                          "Bienvenido de nuevo!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFF00C48E),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Email
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 61),
                        child: Text(
                          "Email",
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color(0xFF132D46),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 61, right: 61, top: 3),
                      child: SizedBox(
                        height: 26,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "email@gmail.com",
                            hintStyle: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                              color: Color.fromRGBO(19, 45, 70, 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF132D46)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Contraseña
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 61),
                        child: Text(
                          "Contraseña",
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color(0xFF132D46),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 61, right: 61, top: 3),
                      child: SizedBox(
                        height: 26,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Ingresa tu contraseña",
                            hintStyle: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                              color: Color.fromRGBO(19, 45, 70, 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF132D46)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Color(0xFF132D46)),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    // Botón iniciar sesión
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 61),
                      child: SizedBox(
                        width: double.infinity,
                        height: 26,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C48E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onPressed: _login,
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // ¿No tienes cuenta? Regístrate ahora
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 61),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿No tienes cuenta?",
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.register);
                              },
                            child: const Text(
                              "Regístrate ahora",
                              style: TextStyle(
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                color: Color(0xFF00C48E),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}