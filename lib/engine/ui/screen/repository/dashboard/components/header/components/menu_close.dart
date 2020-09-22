import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuCloseButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuCloseButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: MenuButton("close", "images/ic_menu_close.svg", (){
        Navigator.pop(context);
      }),
    );
  }
}
