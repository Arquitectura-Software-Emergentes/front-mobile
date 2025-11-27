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
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("lib/assets/images/Cuenta.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: _loading || _profile == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 120),

                // FOTO DE PERFIL
                CircleAvatar(
                  radius: 42,
                  backgroundImage: AssetImage(_profile!.avatarUrl),
                ),

                const SizedBox(height: 12),

                Text(
                  _profile!.name,
                  style: const TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF132D46),
                  ),
                ),

                Text(
                  _profile!.email,
                  style: const TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: 12,
                    color: Color(0xFF00C48E),
                  ),
                ),

                const SizedBox(height: 28),

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
