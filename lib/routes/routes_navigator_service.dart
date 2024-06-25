import 'dart:async';

import 'package:get/get.dart';

import '../model/configs/fixtures.dart';

abstract class RoutesNavigatorService {
  Future<void> toInitial();
  Future<void> closeApp();
  Future<void> remplaceAllToSplash();
  Future<void> remplaceAllToHome();
  Future<void> remplaceAllTologin();
  Future<void> toInfoResult(Fixtures fixtures);
  Future<void> toBack();

  String get initialRoute;
  String get getInitialLoading;
  List<GetPage> get routes;
  Map<String, dynamic>? get initialArguments;
  Map<String, dynamic>? get arguments;
  String get routeName;
  bool get isEmpty;
  void onRedirect(String routeName, {Map<String, dynamic>? arguments});
}
