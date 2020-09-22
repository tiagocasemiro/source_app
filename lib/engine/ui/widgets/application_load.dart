import 'package:load/load.dart';

class Load {

  static void show() {
    showLoadingDialog(tapDismiss: false);
  }

  static void hide() {
    hideLoadingDialog();
  }
}