import 'package:flutter/material.dart';
import '../../domain/usecases/get_reports_usecase.dart';
import '../../data/repositories/report_repository_impl.dart';
import '../../domain/entities/report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
    // Helper to filter reports by search and filter
    List<Report> _filterReports(List<Report> reports) {
      List<Report> filtered = reports;
      if (selectedFilter != 0) {
        final filter = filters[selectedFilter].toLowerCase();
        filtered = filtered.where((r) => r.status.toLowerCase().contains(filter)).toList();
      }
      if (searchQuery.trim().isNotEmpty) {
        final query = searchQuery.trim().toLowerCase();
        filtered = filtered.where((r) =>
          r.title.toLowerCase().contains(query) ||
          r.description.toLowerCase().contains(query)
        ).toList();
      }
      return filtered;
    }
  late Future<List<Report>> _reportsFuture;

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  int selectedFilter = 0;
  final filters = [
    "Todos",
    "Procesando",
    "Recibidos",
    "En proceso",
    "Resueltos",
  ];

  @override
  void initState() {
    super.initState();
    final repository = ReportRepositoryImpl();
    final usecase = GetReportsUsecase(repository);
    _reportsFuture = usecase();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Report>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay reportes disponibles"));
          }

          final reports = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // -----------------------------
                //         TÍTULO PRINCIPAL
                // -----------------------------
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 24),
                  child: Text(
                    "Mis reportes",
                    style: TextStyle(
                      fontFamily: "Space Grotesk",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF132D46),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    "${reports.length} de ${reports.length} reportes",
                    style: const TextStyle(
                      fontFamily: "Space Grotesk",
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF65727A),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // -----------------------------
                //               BUSCADOR
                // -----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE4E4E4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF9F9F9F)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() => searchQuery = value);
                            },
                            decoration: const InputDecoration(
                              hintText: "Buscar por ubicación o descripción...",
                              hintStyle: TextStyle(
                                fontFamily: "Space Grotesk",
                                color: Color(0xFF9F9F9F),
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: const TextStyle(
                              fontFamily: "Space Grotesk",
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // -----------------------------
                //              FILTROS
                // -----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => setState(() => selectedFilter = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selectedFilter == i
                                ? const Color(0xFF00C48E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: selectedFilter == i
                                  ? Colors.transparent
                                  : const Color(0xFF132D46),
                            ),
                          ),
                          child: Text(
                            filters[i],
                            style: TextStyle(
                              fontFamily: "Space Grotesk",
                              fontSize: 13,
                              fontWeight: selectedFilter == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: selectedFilter == i
                                  ? Colors.white
                                  : const Color(0xFF132D46),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemCount: filters.length,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // -----------------------------
                //         LISTA DE REPORTES
                // -----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: _filterReports(reports)
                        .map((r) => _ReportCard(report: r, maxWidth: width))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =======================================================
//                     CARD - FIGMA EXACTO
// =======================================================
class _ReportCard extends StatelessWidget {
  final Report report;
  final double maxWidth;
  const _ReportCard({required this.report, required this.maxWidth});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'recibido':
        return const Color(0xFF132D46);
      case 'resuelto':
        return const Color(0xFF00C48E);
      case 'en proceso':
        return const Color(0xFFC47C00);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = 90.0;
    final imageHeight = 70.0;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage("lib/assets/images/sample1.jpg"),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: Image.asset(
              "lib/assets/images/sample1.jpg",
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 40),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(report.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("Magdalena, Lima",
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Text(_getTimeAgo(report.date),
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Text(report.description,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: report.status == "Recibido"
                            ? const Color(0xFF132D46)
                            : const Color(0xFF00C48E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        report.status,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 0) {
      return diff.inDays == 1 ? "Ayer" : "Hace ${diff.inDays} días";
    }
    if (diff.inHours > 0) return "Hace ${diff.inHours} horas";
    if (diff.inMinutes > 0) return "Hace ${diff.inMinutes} min";
    return "Ahora";
  }
}
