import '../../domain/entities/home_data.dart';
import '../datasources/home_mock_datasource.dart';
import '../datasources/home_supabase_datasource.dart';

class HomeRepositoryImpl {
  final bool useMock;
  final HomeMockDatasource mockDatasource;
  final HomeSupabaseDatasource supabaseDatasource;

  HomeRepositoryImpl({
    this.useMock = true,
    HomeMockDatasource? mockDatasource,
    HomeSupabaseDatasource? supabaseDatasource,
  })  : mockDatasource = mockDatasource ?? HomeMockDatasource(),
        supabaseDatasource = supabaseDatasource ?? HomeSupabaseDatasource();

  Future<HomeData> fetchHomeData() async {
    if (useMock) {
      return mockDatasource.fetchHomeData();
    } else {
      return await supabaseDatasource.fetchHomeDataFromSupabase();
    }
  }
}
