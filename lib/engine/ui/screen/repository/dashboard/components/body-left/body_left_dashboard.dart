import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/local_branches.dart';



class BodyLeftDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LocalBranches(),
        ],
      ),
    );
  }
}
