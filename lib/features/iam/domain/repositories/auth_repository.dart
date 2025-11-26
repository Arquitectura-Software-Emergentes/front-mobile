import '../entities/user.dart';

//Define solo metodos no implementacion
abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password);
}