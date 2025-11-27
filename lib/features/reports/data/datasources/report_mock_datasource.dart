import '../../domain/entities/report.dart';

class ReportMockDatasource {
  Future<List<Report>> fetchReports() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Report(
        id: '1',
        title: 'Reporte de Basura',
        description: 'Acumulación de basura en la calle principal.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Pendiente',
      ),
      Report(
        id: '2',
        title: 'Fuga de Agua',
        description: 'Fuga de agua cerca del parque.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Resuelto',
      ),
    ];
  }
}
