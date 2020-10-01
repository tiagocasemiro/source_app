import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/alert_merge.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';

class MenuMergeButton extends StatelessWidget {
  final HeaderViewModel _headerViewModel;

  MenuMergeButton(this._headerViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("merge", "images/ic_menu_merge.svg", (){
      MergeAlert(_headerViewModel).displayAlert(context);
    });
  }
}
