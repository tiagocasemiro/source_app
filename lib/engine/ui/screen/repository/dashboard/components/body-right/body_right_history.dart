import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/dashboard_history.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/commit_files.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/diff_file.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';
import 'package:flutter/material.dart';

class BodyRightHistory extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  const BodyRightHistory(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalSplitView(
        ratio: 0.60,
        up: Container(
          padding: const EdgeInsets.only(
              right: defaultPaddingSize, top: defaultPaddingSize),
          child: HistoryDashboard(),
        ),
        down: Container(
          child: VerticalSplitView(
            left: Container(
              padding: const EdgeInsets.only(bottom: defaultPaddingSize),
              child: CommitFiles(_bodyRightViewModel),
            ),
            right: Container(
              padding: const EdgeInsets.only(
                  right: defaultPaddingSize, bottom: defaultPaddingSize),
              child: FileDiff(_bodyRightViewModel),
            ),
          ),
        ),
      ),
    );
  }
}
