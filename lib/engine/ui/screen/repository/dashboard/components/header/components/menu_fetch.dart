import 'package:flutter/material.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';

class MenuFetchButton extends StatelessWidget {
  final HeaderViewModel _headerViewModel;

  MenuFetchButton(this._headerViewModel);

  @override
  Widget build(BuildContext context) {
    return MenuButton("fetch", "images/ic_menu_fetch.svg", (){
      Load.show();
      _headerViewModel.fetch().then((GitOutput gitOutput) {
        Load.hide();
        if(gitOutput.isFailure()) {
          GitOutputErrorAlert(context).displayAlert(gitOutput.message);
        } else {
          Notify(context).showSuccessWithMessage(gitOutput);
        }
      }, onError: (e) => Load.hide());
    });
  }
}
