import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/widget/menu_button.dart';
import 'package:flutter/material.dart';

class MenuCommitButton extends StatelessWidget {
  final HeaderViewModel _headerViewModel;

  MenuCommitButton(this._headerViewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: MenuButton("commit", "images/ic_menu_commit.svg", (){
        _headerViewModel.displayCommit();
      }),
    );
  }
}
