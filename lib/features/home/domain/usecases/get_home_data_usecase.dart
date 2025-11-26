import '../entities/home_data.dart';
import '../../data/repositories/home_repository_impl.dart';

class GetHomeDataUsecase {
  final HomeRepositoryImpl repository;

  GetHomeDataUsecase({required this.repository});

  Future<HomeData> call() async {
    return await repository.fetchHomeData();
  }
}
