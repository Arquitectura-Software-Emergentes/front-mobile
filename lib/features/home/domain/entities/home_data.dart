class HomeData {
  final String userName;
  final int totalReports;
  final int pendingReports;
  final int resolvedReports;
  final List<Activity> activities;
  final CommunityImpact impact;

  HomeData({
    required this.userName,
    required this.totalReports,
    required this.pendingReports,
    required this.resolvedReports,
    required this.activities,
    required this.impact,
  });
}

class Activity {
  final String title;
  final String location;
  final String timeAgo;
  final String description;
  final String status;
  final String imageUrl;

  Activity({
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.description,
    required this.status,
    required this.imageUrl,
  });
}

class CommunityImpact {
  final int totalIncidents;
  final String message;

  CommunityImpact({
    required this.totalIncidents,
    required this.message,
  });
}
