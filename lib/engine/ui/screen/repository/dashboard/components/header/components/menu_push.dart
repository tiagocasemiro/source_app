import 'package:flutter/material.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_success_snackbar.dart';

class MenuPushButton extends StatelessWidget {
  final HeaderViewModel _headerViewModell;

  MenuPushButton(this._headerViewModell);

  @override
  Widget build(BuildContext context) {
    return MenuButton("push", "images/ic_menu_push.png", (){
      _headerViewModell.push().then((GitOutput gitOutput) {
        if(gitOutput.isFailure()) {
          GitOutputErrorAlert(gitOutput).displayAlert(context);
        } else {
          GitOutputSuccessSnackBar(context).showWithMessage(gitOutput);
        }
      });
    });
  }
}
