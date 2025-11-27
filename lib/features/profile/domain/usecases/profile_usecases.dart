import '../../data/repositories/profile_repository_impl.dart';
import '../entities/profile.dart';

class GetProfileUsecase {
  final ProfileRepository repository;
  GetProfileUsecase({required this.repository});

  Future<Profile> call() async {
    return await repository.getProfile();
  }
}

class UpdateProfileUsecase {
  final ProfileRepository repository;
  UpdateProfileUsecase({required this.repository});

  Future<void> call(Profile profile) async {
    await repository.updateProfile(profile);
  }
}
