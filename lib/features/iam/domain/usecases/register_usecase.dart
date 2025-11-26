import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<User> call(String fullName, String email, String password) {
    return repository.register(fullName, email, password);
  }
}