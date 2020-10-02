import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_branch.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_close.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_fetch.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_merge.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_pull.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_push.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/components/menu_stash.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class HeaderDashboard extends StatelessWidget {
  final HeaderViewModel _dashboardViewModel;

  HeaderDashboard(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SourceColors.grey[2],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          MenuCommitButton(_dashboardViewModel),
          Container(width: 36,),
          MenuPushButton(_dashboardViewModel),
          MenuPullButton(_dashboardViewModel),
          MenuFetchButton(_dashboardViewModel),
          Container(width: 36,),
          MenuBranchButton(_dashboardViewModel),
          MenuMergeButton(_dashboardViewModel),
          Container(width: 36,),
          MenuStashButton(_dashboardViewModel),
          Expanded(child: Container(),),
          MenuCloseButton(_dashboardViewModel),
        ],
      ),
    );
  }
}
