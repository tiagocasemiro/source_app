import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuFetchButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuFetchButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("fetch", "images/ic_menu_fetch.svg", (){
      print("fetch");
    });
  }
}
