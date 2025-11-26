import '../../domain/entities/home_data.dart';

class HomeMockDatasource {
  HomeData fetchHomeData() {
    return HomeData(
      userName: 'Barbara Quezada',
      totalReports: 10,
      pendingReports: 3,
      resolvedReports: 4,
      activities: [
        Activity(
          title: 'Bache en SJL',
          location: 'Av. Gran Pajatén, Lima',
          timeAgo: 'Hace 2 horas',
          description: 'Bache profundo en el carril derecho de la avenida Chimú en el cruce de Malecón Checa',
          status: 'Recibido',
          imageUrl: 'lib/assets/images/bache_sjl.png',
        ),
        Activity(
          title: 'Basura en Magdalena',
          location: 'Magdalena, Lima',
          timeAgo: 'Ayer',
          description: 'Basura acumulada en el carril derecho de la avenida Chimú en el cruce de Malecón Checa',
          status: 'En proceso',
          imageUrl: 'lib/assets/images/basura_magdalena.png',
        ),
      ],
      impact: CommunityImpact(
        totalIncidents: 47,
        message: 'Esta semana la comunidad reportó 47 incidencias. Tu participación hace la diferencia.',
      ),
    );
  }
}
