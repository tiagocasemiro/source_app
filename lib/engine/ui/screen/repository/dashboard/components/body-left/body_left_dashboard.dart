import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/components/local_branches.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/components/remote_branches.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/components/stashs.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/components/tags.dart';


class BodyLeftDashboard extends StatelessWidget {
  final BodyLeftViewModel _dashboardViewModel;

  BodyLeftDashboard(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: _dashboardViewModel.localBranchesOutput,
              builder: (_, __) {
                return LocalBranches(_dashboardViewModel);
              },
            ),
            Container(height: 10, width: double.maxFinite,),
            RemoteBranches(_dashboardViewModel),
            Container(height: 10, width: double.maxFinite,),
            TagsDashboard(_dashboardViewModel),
            Container(height: 10, width: double.maxFinite,),
            StashDashboard(_dashboardViewModel),
            Container(height: 5, width: double.maxFinite,),
          ],
        ),
      ),
    );
  }
}
