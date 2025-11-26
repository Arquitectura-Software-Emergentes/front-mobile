import '../entities/user.dart';
import '../repositories/auth_repository.dart';

// Lo llaman los BLOC y UI, son la puerta para la capa de presentacion y dominio.
class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}