class HistoryPage {
  final String route;
  final Map<String, dynamic>? arguments;

  HistoryPage({
    required this.route,
    this.arguments,
  });

  factory HistoryPage.fromJson(Map<String, dynamic> json) {
    return HistoryPage(
      route: json['route'],
      arguments: json['arguments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'route': route,
      'arguments': arguments,
    };
  }

  @override
  String toString() {
    return 'HistoryPage{route: $route, arguments: $arguments}';
  }
}
