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
    // Controllers for editable fields
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _birthDateController = TextEditingController();
    final TextEditingController _dniController = TextEditingController();
    final TextEditingController _occupationController = TextEditingController();

    @override
    void dispose() {
      _nameController.dispose();
      _emailController.dispose();
      _phoneController.dispose();
      _addressController.dispose();
      _birthDateController.dispose();
      _dniController.dispose();
      _occupationController.dispose();
      super.dispose();
    }
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
      // Set controllers with profile data
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone;
      _addressController.text = profile.address;
      _birthDateController.text = "${profile.birthDate.day.toString().padLeft(2, '0')}/${profile.birthDate.month.toString().padLeft(2, '0')}/${profile.birthDate.year}";
      _dniController.text = profile.dni;
      _occupationController.text = profile.occupation;
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
                    // NOMBRE
                    _buildEditableLabel("Nombre", _nameController, fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF132D46)),
                    // EMAIL
                    _buildEditableLabel("Email", _emailController, fontSize: 12, color: Color(0xFF00C48E)),
                    const SizedBox(height: 28),
                    _buildLabel("Teléfono"),
                    _buildEditableBox(_phoneController),
                    _buildLabel("Dirección"),
                    _buildEditableBox(_addressController),
                    _buildLabel("Fecha de nacimiento"),
                    _buildEditableBox(_birthDateController),
                    _buildLabel("DNI"),
                    _buildEditableBox(_dniController),
                    _buildLabel("Ocupación"),
                    _buildEditableBox(_occupationController),
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
                        onPressed: () {
                          setState(() {
                            _profile = Profile(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              address: _addressController.text,
                              birthDate: _profile!.birthDate, // For simplicity, keep as DateTime
                              dni: _dniController.text,
                              occupation: _occupationController.text,
                              avatarUrl: _profile!.avatarUrl,
                            );
                          });
                        },
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

  Widget _buildEditableLabel(String label, TextEditingController controller, {double fontSize = 14, FontWeight fontWeight = FontWeight.w400, Color color = const Color(0xFF132D46)}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 16),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: 'Space Grotesk',
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color.withOpacity(0.5),
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildEditableBox(TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 38,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF132D46)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0x80132D46),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
