import '../../domain/entities/profile.dart';
import '../datasources/profile_datasource.dart';

class ProfileRepository {
  final ProfileDatasource datasource;
  ProfileRepository({required this.datasource});

  Future<Profile> getProfile() => datasource.getProfile();
  Future<void> updateProfile(Profile profile) => datasource.updateProfile(profile);
}
