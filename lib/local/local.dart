import 'package:deporte_app_flutter/model/configs/fixtures.dart';
import 'package:get/get.dart';

import '../model/history_page.dart';

abstract class Local {
  Future<List<HistoryPage>?> getNavigatorHistory();
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory);
  Future<void> deleteAll();
  Future<Fixtures?> getUserToEdit();
   Future<void> setUserToEdit(Fixtures fixtures);
}
