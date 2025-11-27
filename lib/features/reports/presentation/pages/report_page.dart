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
  late Future<List<Report>> _reportsFuture;

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -----------------------------
                //         TÍTULO PRINCIPAL
                // -----------------------------
                const Text(
                  "Mis reportes",
                  style: TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF132D46),
                  ),
                ),
                const SizedBox(height: 5),

                Text(
                  "${reports.length} de ${reports.length} reportes",
                  style: const TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF65727A),
                  ),
                ),
                const SizedBox(height: 20),

                // -----------------------------
                //               BUSCADOR
                // -----------------------------
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE4E4E4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFF9F9F9F)),
                      SizedBox(width: 10),
                      Text(
                        "Buscar por ubicación o descripción...",
                        style: TextStyle(
                          fontFamily: "Space Grotesk",
                          color: Color(0xFF9F9F9F),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // -----------------------------
                //              FILTROS
                // -----------------------------
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () => setState(() => selectedFilter = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
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
                            fontSize: 14,
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
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: filters.length,
                  ),
                ),

                const SizedBox(height: 20),

                // -----------------------------
                //         LISTA DE REPORTES
                // -----------------------------
                ...reports.map((r) => _ReportCard(report: r)).toList(),
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
  const _ReportCard({required this.report});

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
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          // IMAGEN GRANDE (FIGMA)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              "lib/assets/images/sample1.jpg", // reemplaza según tu imagen
              width: 140,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título + Estado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          report.title,
                          style: const TextStyle(
                            fontFamily: "Space Grotesk",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(report.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          report.status,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: "Space Grotesk",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 12, color: Color(0xFF9F9F9F)),
                      const SizedBox(width: 4),
                      const Text(
                        "Magdalena, Lima",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9F9F9F),
                          fontFamily: "Space Grotesk",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 12, color: Color(0xFF9F9F9F)),
                      const SizedBox(width: 4),
                      Text(
                        _getTimeAgo(report.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9F9F9F),
                          fontFamily: "Space Grotesk",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    report.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9F9F9F),
                      fontFamily: "Space Grotesk",
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
