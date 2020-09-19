import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';

class MenuCommitButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuCommitButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: MenuButton("commit", "images/ic_menu_commit.png", (){
        print("commit");
      }),
    );
  }
}
