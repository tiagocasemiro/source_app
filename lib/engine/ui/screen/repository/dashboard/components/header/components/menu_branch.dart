import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/alert_branch.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuBranchButton extends StatelessWidget {
  final HeaderViewModel _headerViewModel;

  MenuBranchButton(this._headerViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("branch","images/ic_menu_branch.svg", () {
      NewBranchAlert(_headerViewModel).displayAlert(context);
    });
  }
}
