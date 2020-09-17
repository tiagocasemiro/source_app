import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/local_branches.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/remote_branches.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';

class BodyLeftDashboard extends StatelessWidget {
  final DashboardViewModel _dashboardViewModel;

  BodyLeftDashboard(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: _dashboardViewModel.localBranchesOutput,
            builder: (_, __) {
              return LocalBranches(_dashboardViewModel);
            },
          ),
          Container(height: 10, width: double.maxFinite,),
          Flexible(child: RemoteBranches(_dashboardViewModel)),
          Container(height: 5, width: double.maxFinite,),
        ],
      ),
    );
  }
}
