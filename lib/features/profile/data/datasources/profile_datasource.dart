import '../../domain/entities/profile.dart';

abstract class ProfileDatasource {
  Future<Profile> getProfile();
  Future<void> updateProfile(Profile profile);
}

class ProfileMockDatasource implements ProfileDatasource {
  @override
  Future<Profile> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Profile(
      name: 'Nombre Usuario',
      email: 'usuario@email.com',
      phone: '+51 999 999 999',
      address: 'Av. Ejemplo 123, Lima',
      birthDate: DateTime(2000, 1, 1),
      dni: '12345678',
      occupation: 'Estudiante',
      avatarUrl: 'lib/assets/images/user.png',
    );
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // No-op for mock
  }
}

// Example for real datasource (Supabase, Firebase, etc.)
class ProfileSupabaseDatasource implements ProfileDatasource {
  @override
  Future<Profile> getProfile() async {
    // TODO: Implement real DB fetch
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    // TODO: Implement real DB update
    throw UnimplementedError();
  }
}
