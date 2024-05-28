import '../model/history_page.dart';

abstract class LocalService {
  // gets
  Future<List<HistoryPage>?> getNavigatorHistory();
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory);
   Future<void> clear();
}
