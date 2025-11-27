import '../../domain/entities/report.dart';
import '../datasources/report_mock_datasource.dart';
import '../datasources/report_supabase_datasource.dart';

class ReportRepositoryImpl {
  final bool useMock;
  final ReportMockDatasource mockDatasource;
  final ReportSupabaseDatasource supabaseDatasource;

  ReportRepositoryImpl({
    this.useMock = true,
    ReportMockDatasource? mockDatasource,
    ReportSupabaseDatasource? supabaseDatasource,
  })  : mockDatasource = mockDatasource ?? ReportMockDatasource(),
        supabaseDatasource = supabaseDatasource ?? ReportSupabaseDatasource();

  Future<List<Report>> fetchReports() async {
    if (useMock) {
      return await mockDatasource.fetchReports();
    } else {
      return await supabaseDatasource.fetchReports();
    }
  }
}
