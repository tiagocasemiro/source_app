import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/dashboard_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/diff_file.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/staged_files.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/unstaged_files.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';
import 'package:flutter/material.dart';

class BodyRightCommit extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  const BodyRightCommit( this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalSplitView(
        ratio: 0.70,
        up: Container(
          padding: const EdgeInsets.only(top: defaultPaddingSize),
          child: VerticalSplitView(
            left: Container(
              padding: const EdgeInsets.only(),
              child: HorizontalSplitView(
                ratio: 0.50,
                up: StagedFiles(_bodyRightViewModel),
                down: UnstagedFiles(_bodyRightViewModel),
              ),
            ),
            right: Container(
              padding: const EdgeInsets.only(right: defaultPaddingSize),
              child: FileDiff(_bodyRightViewModel),
            ),
          ),
        ),
        down: Container(
          padding: const EdgeInsets.only(right: defaultPaddingSize, bottom: defaultPaddingSize),
          child: CommitDashboard(),
        ),
      ),
    );
  }
}
