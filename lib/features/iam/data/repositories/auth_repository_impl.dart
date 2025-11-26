import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

//Recibe peticiones de la capa de dominio y las traduce a llamadas al datasource.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<User> register(String fullName, String email, String password) {
    return remoteDatasource.register(fullName, email, password);
  }
}