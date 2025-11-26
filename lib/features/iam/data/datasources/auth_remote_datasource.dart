import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

// Sabe como interactuar con Supabase(se conecta directamente),
// más no con la lógica de negocio como: validaciones, etc.
class AuthRemoteDatasource {
  final SupabaseClient client = Supabase.instance.client;

  Future<UserModel> login(String email, String password) async {
    final response = await client.auth.signInWithPassword(email: email, password: password);
    if (response.user == null) throw Exception('Login failed');
    final userData = await client
        .from('users')
        .select()
        .eq('id', response.user!.id)
        .single();
    return UserModel.fromJson(userData);
  }

  Future<UserModel> register(String fullName, String email, String password) async {
    final response = await client.auth.signUp(email: email, password: password);
    if (response.user == null) throw Exception('Register failed');
    await client.from('users').insert({
      'id': response.user!.id,
      'full_name': fullName,
      'user_type': 'CITIZEN',
    });
    return UserModel(
      id: response.user!.id,
      fullName: fullName,
      email: email,
      userType: 'CITIZEN',
    );
  }
}