import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/alert_stash.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuStashButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuStashButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("stash", "images/ic_menu_stash.svg", (){
      CreateStashAlert(_dashboardViewModel).displayAlert(context);
    });
  }
}
