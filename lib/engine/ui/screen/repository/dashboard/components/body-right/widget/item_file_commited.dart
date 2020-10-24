import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';

class ItemFileCommitted extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;
  final GitFileModified fileCommitted;

  const ItemFileCommitted(this._bodyRightViewModel, this.fileCommitted);

  @override
  Widget build(BuildContext context) {
    return Material(child:
      InkWell(child:
        Container(
          child: Text(fileCommitted.name)
        ),
        onTap: () {
          fileCommitted.stageFile = StageFile.committed;
          _bodyRightViewModel.displayFileDiff(fileCommitted);
        },
      )
    );
  }
}
