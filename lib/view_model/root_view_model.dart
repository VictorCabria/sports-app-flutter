import 'package:get/get.dart';
import '../repository/app_configuration_service.dart';

abstract class RootViewModel extends GetxController {
  AppConfigurationService? _appConfigurationService;

  RootViewModel(this._appConfigurationService);
  RxBool loading = false.obs;
  final RxString _showErrorString = "".obs;
  final RxString _labelErrorTitle = "".obs;
  final RxString _textButtonError = "".obs;

  final RxString _errorTitle = "Error".obs;
  final RxString _buttonCloseLabel = "Close".obs;
  final RxBool _internetConnectionError = false.obs;

  Function? _buttonErrorFunction;

  initialize();

  RxString get showErrorString => _showErrorString;
  RxString get labelErrorTitle => _labelErrorTitle;
  RxString get textButtonError => _textButtonError;

  RxString get errorTitle => _errorTitle;
  RxString get buttonCloseLabel => _buttonCloseLabel;
  RxBool get internetConnectionError => _internetConnectionError;

  void showProgress() => loading.value = true;

  void hideProgress() => loading.value = false;

  void showError({
    String? message,
    Function? buttonErrorFunction,
    String? title,
    String? textButton,
  }) {
    _showErrorString.value = message ?? "";
    _buttonErrorFunction = buttonErrorFunction;
  }

  void hideError() {
    _showErrorString.value = "";
    _buttonErrorFunction != null ? _buttonErrorFunction!() : null;
    _buttonErrorFunction = null;
  }

  void internetConnectionTryAgain() {
    _internetConnectionError.value = false;
    refreshPage();
  }

  refreshPage() {}

  void showInternetConnectionError() {
    _internetConnectionError.value = true;
  }

  void hideInternetConnectionError() {
    _internetConnectionError.value = false;
  }
}
