import 'package:get/get.dart';


abstract class RoutesNavigatorService {
  Future<void> toHome();
  Future<void> toUserProfile();
  Future<void> toNewUserProfile();
  Future<void> toPrivacyPolicy();
  Future<void> toTermsUse();
  Future<void> toFaq();
  Future<void> toServiceChannel();

  Future<void> toConsultationCredits();
  Future<void> toNewConsultationCredits();
  Future<void> toEditProfile();
  Future<void> toNewEditProfile();
  Future<void> toMaps();
  Future<void> toInitial();
  Future<void> toLogin();
  Future<void> toRegister();
  Future<void> toRecoveryPassword();
  Future<void> toResetPassword();
  Future<void> toWaitingRoom();

  Future<void> toShope();

  Future<void> toOnBoarding();
  Future<void> toBack();
  Future<void> toReturn();
  Future<void> toChooseCountryLanguage();
  Future<void> toChooseLanguage();
  Future<void> toNewRegister();
  Future<void> toNewLogin();
  Future<void> closeApp();
  Future<void> remplaceAllToHome();
  Future<void> remplaceAllToSplash();
  Future<void> remplaceAllToNewLogin();
  Future<void> remplaceToInitial();
  Future<void> remplaceToHome();
  Future<void> remplaceToLogin();
  Future<void> remplaceToNewLogin();
  Future<void> remplaceToRegister();
  Future<void> remplaceToNewHome();
  Future<void> remplaceToRecoveryPassword();
  Future<void> remplaceToWaitingRoom();
  Future<void> remplaceToScheduleRoom();
  Future<void> remplaceToShope();
  Future<void> remplaceToMaps();
  Future<void> remplaceToIframe();
  Future<void> remplaceWelcome();
  Future<void> remplaceWelcome1();
  Future<void> remplaceWelcome2();
  Future<void> remplaceWelcome3();
  Future<void> remplaceToOnbording();
  Future<void> remplaceToChooseCountryLanguage();
  Future<void> remplaceToChooseLanguage();
  Future<void> remplaceToNewRegister();

  String get initialRoute;
  String get getInitialLoading;
  List<GetPage> get routes;
  Map<String, dynamic>? get initialArguments;
  Map<String, dynamic>? get arguments;
  String get routeName;
  bool get isEmpty;
  void onRedirect(String routeName, {Map<String, dynamic>? arguments});
}
