import '../../../iam/domain/entities/user.dart';
import '../../../iam/domain/repositories/auth_repository.dart';

class AuthRepositoryMock implements AuthRepository {
  static User? _mockUser;
  static const String mockEmail = 'mock@user.com';
  static const String mockPassword = 'password123';

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 250)); // simula latencia
    // Si ya hay user mock creado y coinciden credenciales, retorna
    if (_mockUser != null && email == _mockUser!.email && password == mockPassword) {
      return _mockUser!;
    }
    // Permite login directo con las credenciales fijas
    if (email == mockEmail && password == mockPassword) {
      final user = User(
        id: 'mock-id',
        fullName: 'Usuario Mock',
        email: mockEmail,
        userType: 'CITIZEN',
      );
      _mockUser = user;
      return user;
    }
    throw Exception('Credenciales inválidas. Usa ${mockEmail} / ${mockPassword}');
  }

  @override
  Future<User> register(String fullName, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final user = User(
      id: 'mock-id',
      fullName: fullName,
      email: email,
      userType: 'CITIZEN',
    );
    _mockUser = user;
    return user;
  }

  // Opcional: recuperar el usuario actual en otras partes
  static User? get currentUser => _mockUser;
}