import '../di/local.dart';
import '../domain/local_service.dart';
import '../model/history_page.dart';

class LocalServiceImpl extends LocalService {
  final Local _local;

  LocalServiceImpl(this._local);

  // gets
  @override
  @override
  Future<List<HistoryPage>?> getNavigatorHistory() {
    return _local.getNavigatorHistory();
  }

  @override
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory) {
    return _local.setNavigatorHistory(navigatorHistory);
  }

  // sets

 @override
  Future<void> clear() async {
    return _local.deleteAll();
  }
}
