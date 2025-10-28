import 'package:flutter/material.dart';
import '../../../../core/config/AppRoutes.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  Future<void> _register() async {
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }
    try {
      final datasource = AuthRemoteDatasource();
      final repository = AuthRepositoryImpl(datasource);
      final usecase = RegisterUsecase(repository);

      final user = await usecase(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso: ${user.fullName}')),
      );
      // Navega a login o home
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizes
    final size = MediaQuery.of(context).size;
    final double boxWidth = size.width * 0.95;
    final double boxHeight = size.height * 0.90;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background_registro.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: boxWidth > 363 ? 363 : boxWidth,
              height: boxHeight > 671 ? 671 : boxHeight,
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
                      width: 135,
                      height: 30,
                      child: Center(
                        child: Text(
                          "Welcome to Back",
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

                    // Nombre
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 62),
                        child: Text(
                          "Nombre",
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
                      padding: const EdgeInsets.only(left: 62, right: 62, top: 3),
                      child: SizedBox(
                        height: 26,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Ingresa tu nombre",
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

                    // Email
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 62),
                        child: Text(
                          "Correo electrónico",
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
                      padding: const EdgeInsets.only(left: 62, right: 62, top: 3),
                      child: SizedBox(
                        height: 26,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Ingresa tu correo",
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
                        padding: const EdgeInsets.only(left: 62),
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
                      padding: const EdgeInsets.only(left: 62, right: 62, top: 3),
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
                    SizedBox(height: size.height * 0.02),

                    // Confirmar contraseña
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 62),
                        child: Text(
                          "Confirmar contraseña",
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
                      padding: const EdgeInsets.only(left: 62, right: 62, top: 3),
                      child: SizedBox(
                        height: 26,
                        child: TextField(
                          controller: _confirmController,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            hintText: "Repite tu contraseña",
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
                              icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: Color(0xFF132D46)),
                              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),

                    // Botón registrarse
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 62),
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
                          onPressed: _register,
                          child: const Text(
                            "Registrarse",
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

                    // ¿Tienes una cuenta? Inicia Sesión
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 62),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿Tienes una cuenta?",
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
                              Navigator.pushReplacementNamed(context, AppRoutes.login);
                            },
                            child: const Text(
                              "Inicia Sesión",
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