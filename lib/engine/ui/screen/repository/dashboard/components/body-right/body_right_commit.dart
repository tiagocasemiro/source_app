import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/dashboard_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/staged_files.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/unstaged_files.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';
import 'package:flutter/material.dart';

class BodyRightCommit extends StatelessWidget {

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
              child: UnstagedFiles(),
            ),
            right: Container(
              padding: const EdgeInsets.only(right: defaultPaddingSize),
              child: StagedFiles(),
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
