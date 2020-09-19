import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuPullButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuPullButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("pull", "images/ic_menu_pull.png", (){
      print("pull");
    });
  }
}
