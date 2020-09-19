import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuPushButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuPushButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("push", "images/ic_menu_push.png", (){
      print("push");
    });
  }
}
