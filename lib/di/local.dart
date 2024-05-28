import 'package:get/get.dart';

import '../model/history_page.dart';

abstract class Local {
  Future<List<HistoryPage>?> getNavigatorHistory();
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory);
  Future<void> deleteAll();
}
