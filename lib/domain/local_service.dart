import '../model/configs/fixtures.dart';
import '../model/history_page.dart';

abstract class LocalService {
  // gets
  Future<List<HistoryPage>?> getNavigatorHistory();
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory);
   Future<Fixtures?> getUserToEdit();
    Future<void> setUserToEdit(Fixtures fixtures);
   Future<void> clear();
}
