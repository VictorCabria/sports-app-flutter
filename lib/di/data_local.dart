import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../model/history_page.dart';
import 'local.dart';

class DataLocal extends Local {
  final GetStorage _storage;

  DataLocal(this._storage);
  @override
  Future<List<HistoryPage>?> getNavigatorHistory() async {
    final data = await _storage.read('navigatorHistory');
    if (data != null && data is List<dynamic>) {
      return data
          .map((e) => HistoryPage.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (data != null && data is List<HistoryPage>) {
      return data;
    }
    return null;
  }

  @override
  Future<void> setNavigatorHistory(List<HistoryPage> navigatorHistory) async {
    _storage.remove('navigatorHistory');
    _storage.write('navigatorHistory', navigatorHistory);
  }

  @override
  Future<void> deleteAll() async {
    //_storage.erase();

    _storage.remove('navigatorHistory');
  }
}
