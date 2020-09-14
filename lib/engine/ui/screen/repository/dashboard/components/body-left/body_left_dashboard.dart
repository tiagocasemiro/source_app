import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/local_branches.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';



class BodyLeftDashboard extends StatelessWidget {

  final DashboardViewModel _dashboardViewModel;

  BodyLeftDashboard(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LocalBranches(_dashboardViewModel),

        ],
      ),
    );
  }
}
