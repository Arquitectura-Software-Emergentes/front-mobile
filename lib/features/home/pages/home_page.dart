import 'package:flutter/material.dart';

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
        return const Center(child: Text('Reportes'));
      case 2:
        return const Center(child: Text('Reportar'));
      case 3:
        return const Center(child: Text('Mapa'));
      case 4:
        return const Center(child: Text('Perfil'));
      default:
        return _homeView(_homeData!);
    }
  }

  // --------------------------------------------------------
  // VISTA PRINCIPAL - HOME (FIGMA EXACTO)
  // --------------------------------------------------------
  Widget _homeView(HomeData data) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFF00C48E),
        ),

        Positioned(
          top: 158,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(37),
                topRight: Radius.circular(37),
              ),
            ),
          ),
        ),

        // SALUDO
        const Positioned(
          top: 44,
          left: 160,
          child: SizedBox(
            width: 40,
            child: Text(
              "Hola!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Space Grotesk",
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 0.8),
              ),
            ),
          ),
        ),

        Positioned(
          top: 76,
          left: 85,
          child: SizedBox(
            width: 190,
            child: Text(
              data.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Space Grotesk",
                fontWeight: FontWeight.w700,
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // RESUMEN PERSONAL
        const Positioned(
          top: 198,
          left: 28,
          child: Text(
            'Resumen Personal',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF132D46),
            ),
          ),
        ),

        // CARDS DEL RESUMEN
        Positioned(
          top: 229,
          left: 28,
          child: _summaryBox(
            background: const Color(0xFF080808),
            value: "${data.totalReports}",
            title: "Total de Reportes",
            valueColor: Colors.white,
            titleColor: Colors.white,
          ),
        ),

        Positioned(
          top: 229,
          left: 186,
          child: _summaryBox(
            background: Colors.white,
            value: "${data.pendingReports}",
            title: "Pendientes",
            valueColor: Colors.black,
            titleColor: Colors.black,
          ),
        ),

        Positioned(
          top: 287,
          left: 28,
          child: _summaryBox(
            background: const Color(0xFF00C48E),
            value: "${data.resolvedReports}",
            title: "Resueltos",
            valueColor: Colors.black,
            titleColor: Colors.black,
            height: 46,
          ),
        ),

        // ACTIVIDAD RECIENTE
        const Positioned(
          top: 338,
          left: 26,
          child: Text(
            "Actividad Reciente",
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF132D46),
            ),
          ),
        ),

        // LISTA DE ACTIVIDADES
        ...List.generate(
          data.activities.length,
              (i) => Positioned(
            top: 370 + (i * 90),
            left: 26,
            child: _activityCard(data.activities[i]),
          ),
        ),

        // IMPACTO COMUNITARIO
        Positioned(
          top: 551,
          left: 25,
          child: Container(
            width: 308,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFBDFFED),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Impacto Comunitario",
                    style: TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    data.impact.message,
                    style: const TextStyle(fontSize: 6),
                  ),
                  const Text(
                    "Ver en mapa",
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
    double width = 148,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: "Space Grotesk",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: valueColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: "Space Grotesk",
              fontWeight: FontWeight.w400,
              fontSize: 5,
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // CARD DE ACTIVIDAD
  // --------------------------------------------------------
  Widget _activityCard(activity) {
    return Container(
      width: 308,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: Row(
        children: [
          Container(
            width: 118,
            height: 79,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(activity.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.title,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500)),
                  Text(activity.location,
                      style: const TextStyle(
                          fontSize: 6, color: Color(0xFF9F9F9F))),
                  Text(activity.timeAgo,
                      style: const TextStyle(
                          fontSize: 6, color: Color(0xFF9F9F9F))),
                  Text(activity.description,
                      style: const TextStyle(
                          fontSize: 6, color: Color(0xFF9F9F9F))),
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
                            fontSize: 6,
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
