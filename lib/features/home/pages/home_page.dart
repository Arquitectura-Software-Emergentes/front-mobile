import 'package:flutter/material.dart';
import 'package:lima_urban_mobile/features/profile/presentation/pages/profile_page.dart';

import '../../reports/presentation/pages/report_page.dart';
import '../domain/usecases/get_home_data_usecase.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/entities/home_data.dart';
import '../../../shared/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final GetHomeDataUsecase _getHomeDataUsecase;

  HomeData? _homeData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getHomeDataUsecase =
        GetHomeDataUsecase(repository: HomeRepositoryImpl(useMock: true));
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    final data = await _getHomeDataUsecase();
    setState(() {
      _homeData = data;
      _loading = false;
    });
  }

  void _onNavbarTap(int index) {
    setState(() => _selectedIndex = index);
  }

  // --------------------------------------------------------
  // PANTALLAS POR SECCIÓN (INICIO, REPORTES, MAPA, PERFIL…)
  // --------------------------------------------------------
  Widget _getSectionWidget(int index) {
    if (_loading || _homeData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (index == 0) {
      return _homeView(_homeData!);
    }

    switch (index) {
      case 1:
        return const ReportPage();        
      case 2:
        return const Center(child: Text('Reportar'));
      case 3:
        return const Center(child: Text('Mapa'));
      case 4:
      return const ProfilePage();
      default:
        return _homeView(_homeData!);
    }
  }

  // --------------------------------------------------------
  // VISTA PRINCIPAL - HOME
  // --------------------------------------------------------
  Widget _homeView(HomeData data) {
    final size = MediaQuery.of(context).size;
    final summaryIcons = [
      'lib/assets/icons/total_report.png', // icono para total de reportes
      'lib/assets/icons/pending_report.png', // icono para pendientes
      'lib/assets/icons/resolved_report.png', // icono para resueltos
    ];
    final impactIcon = 'lib/assets/icons/map_impact.png';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color(0xFF00C48E),
            child: Column(
              children: [
                const SizedBox(height: 44),
                Center(
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      "Hola!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Space Grotesk",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      data.userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Space Grotesk",
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(37),
                topRight: Radius.circular(37),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumen Personal',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF132D46),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _summaryBox(
                          background: const Color(0xFF080808),
                          value: "${data.totalReports}",
                          title: "Total de Reportes",
                          height: 70,
                          valueColor: Colors.white,
                          titleColor: Colors.white,
                          iconPath: summaryIcons[0],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _summaryBox(
                          background: Colors.white,
                          value: "${data.pendingReports}",
                          title: "Pendientes",
                          height: 70,
                          valueColor: Colors.black,
                          titleColor: Colors.black,
                          iconPath: summaryIcons[1],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _summaryBox(
                          background: const Color(0xFF00C48E),
                          value: "${data.resolvedReports}",
                          title: "Resueltos",
                          valueColor: Colors.black,
                          titleColor: Colors.black,
                          height: 70,
                          width: 50,
                          iconPath: summaryIcons[2],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Actividad Reciente",
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF132D46),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    data.activities.length,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _activityCard(data.activities[i]),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 58),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDFFED),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            impactIcon,
                            width: 29,
                            height: 29,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.star, size: 29),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Impacto Comunitario",
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  data.impact.message,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 3;
                                    });
                                  },
                                  child: const Text(
                                    "Ver en mapa",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  // --------------------------------------------------------
  // SUMMARY BOX
  // --------------------------------------------------------
  Widget _summaryBox({
    required String value,
    required String title,
    required Color background,
    required Color valueColor,
    required Color titleColor,
    String? iconPath,
    double width = 148,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(minHeight: height + 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  iconPath,
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.insert_chart, size: 30),
                ),
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: "Space Grotesk",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: valueColor,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Space Grotesk",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: titleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // CARD DE ACTIVIDAD
  // --------------------------------------------------------
  Widget _activityCard(activity) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 70,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(activity.imageUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: Image.asset(
              activity.imageUrl,
              width: 90,
              height: 70,
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
                  Text(activity.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(activity.location,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Text(activity.timeAgo,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Text(activity.description,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9F9F9F))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: activity.status == "Recibido"
                            ? const Color(0xFF132D46)
                            : const Color(0xFF00C48E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        activity.status,
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

  // --------------------------------------------------------
  // BUILD
  // --------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSectionWidget(_selectedIndex),
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedIndex,
        onTap: _onNavbarTap,
      ),
    );
  }
}
