import 'package:flutter/material.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/alert_pull.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';

class MenuPullButton extends StatelessWidget {
  final HeaderViewModel _headerViewModel;

  MenuPullButton(this._headerViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("pull", "images/ic_menu_pull.svg", () {
      PullAlert(_headerViewModel).displayAlert(context);
    });
  }

  void displayOptions() {
    Load.show();
    _headerViewModel.remoteBranches().then((GitOutput gitOutput) {
      Load.hide();


    });
  }
}
