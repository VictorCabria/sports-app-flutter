import '../local/local.dart';
import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../model/history_page.dart';

class LocalServiceImpl extends LocalService {
  final Local _local;

  LocalServiceImpl(this._local);

  // gets
  @override
  Future<List<HistoryPage>?> getNavigatorHistory() {
    return _local.getNavigatorHistory();
  }

  @override
  Future<Fixtures?> getUserToEdit() {
    return _local.getUserToEdit();
  }

  @override
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory) {
    return _local.setNavigatorHistory(navigatorHistory);
  }

  @override
  Future<void> setUserToEdit(Fixtures fixtures) {
    return _local.setUserToEdit(fixtures);
  }

  // sets

  @override
  Future<void> clear() async {
    return _local.deleteAll();
  }
}
