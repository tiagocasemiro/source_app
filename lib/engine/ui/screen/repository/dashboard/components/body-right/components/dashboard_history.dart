import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class HistoryDashboard extends StatelessWidget {

  final BodyRightViewModel _bodyRightViewModel;

  HistoryDashboard(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SourceColors.grey[2],
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}