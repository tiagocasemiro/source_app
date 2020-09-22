import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';

class MenuMergeButton extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  MenuMergeButton(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("merge", "images/ic_menu_merge.png", (){
      print("merge");
    });
  }
}
