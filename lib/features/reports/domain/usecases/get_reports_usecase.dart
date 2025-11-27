import '../entities/report.dart';
import '../../data/repositories/report_repository_impl.dart';

class GetReportsUsecase {
  final ReportRepositoryImpl repository;

  GetReportsUsecase(this.repository);

  Future<List<Report>> call() async {
    return await repository.fetchReports();
  }
}
