//Solo contiene atributos y reglas del negocio.
class User {
  final String id;
  final String fullName;
  final String email;
  final String userType;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userType,
  });
}