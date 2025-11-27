import 'package:flutter/material.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/profile_usecases.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool useMock = true;

  late GetProfileUsecase _getProfileUsecase;
  Profile? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _setupUsecase();
    _fetchProfile();
  }

  void _setupUsecase() {
    final datasource =
        useMock ? ProfileMockDatasource() : ProfileSupabaseDatasource();
    final repository = ProfileRepository(datasource: datasource);
    _getProfileUsecase = GetProfileUsecase(repository: repository);
  }

  Future<void> _fetchProfile() async {
    setState(() => _loading = true);
    final profile = await _getProfileUsecase();
    setState(() {
      _profile = profile;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading || _profile == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // ---------------------------------
                //        FONDO (IMAGEN SUPERIOR)
                // ---------------------------------
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "lib/assets/images/Cuenta.png",
                    width: size.width,
                    height: size.height * 0.22,
                    fit: BoxFit.cover,
                  ),
                ),

                // ---------------------------------
                //         CONTENIDO SCROLLABLE
                // ---------------------------------
                Positioned.fill(
                  top: size.height * 0.12,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        // FOTO DE PERFIL
                        CircleAvatar(
                          radius: 42,
                          backgroundImage: AssetImage(_profile!.avatarUrl),
                        ),

                        const SizedBox(height: 12),

                        // NOMBRE
                        Text(
                          _profile!.name,
                          style: const TextStyle(
                            fontFamily: "Space Grotesk",
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF132D46),
                          ),
                        ),

                        // EMAIL
                        Text(
                          _profile!.email,
                          style: const TextStyle(
                            fontFamily: "Space Grotesk",
                            fontSize: 12,
                            color: Color(0xFF00C48E),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // CAMPOS
                        _buildLabel("Teléfono"),
                        _buildBox(_profile!.phone),

                        _buildLabel("Dirección"),
                        _buildBox(_profile!.address),

                        _buildLabel("Fecha de nacimiento"),
                        _buildBox(
                          "${_profile!.birthDate.day.toString().padLeft(2, '0')}/"
                          "${_profile!.birthDate.month.toString().padLeft(2, '0')}/"
                          "${_profile!.birthDate.year}",
                        ),

                        _buildLabel("DNI"),
                        _buildBox(_profile!.dni),

                        _buildLabel("Ocupación"),
                        _buildBox(_profile!.occupation),

                        const SizedBox(height: 20),

                        // BOTÓN ACTUALIZAR
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00C48E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Actualizar",
                              style: TextStyle(
                                fontFamily: "Space Grotesk",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // ---------------------------------
  //         WIDGETS REUTILIZABLES
  // ---------------------------------

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Color(0xFF132D46),
          ),
        ),
      ),
    );
  }

  Widget _buildBox(String text) {
    return Container(
      width: double.infinity,
      height: 38,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF132D46)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0x80132D46),
        ),
      ),
    );
  }
}
