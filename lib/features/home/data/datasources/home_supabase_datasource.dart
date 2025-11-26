import '../../domain/entities/home_data.dart';

class HomeSupabaseDatasource {
  Future<HomeData> fetchHomeDataFromSupabase() async {
    // Aquí iría la lógica real de Supabase
    // Por ahora retorna un mock temporal
    await Future.delayed(const Duration(milliseconds: 500));
    return HomeData(
      userName: 'Barbara Quezada',
      totalReports: 10,
      pendingReports: 3,
      resolvedReports: 4,
      activities: [],
      impact: CommunityImpact(totalIncidents: 47, message: 'Mock desde Supabase'),
    );
  }
}
