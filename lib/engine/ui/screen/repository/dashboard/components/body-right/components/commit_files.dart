import 'package:flutter/material.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';

class CommitFiles extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  CommitFiles(this._bodyRightViewModel);

  //git diff-tree --no-commit-id --name-only -r 03772e053a5d8b2b37d04fbed4f090c2a9c6d3e8


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bodyRightViewModel.filesModifiedFromCommitOutput,
      builder: (context, snapshot) {

        if(snapshot.data is GitOutput) {
          GitOutput gitOutput = snapshot.data as GitOutput;
          if(gitOutput.isSuccess()) {
            print(gitOutput.message);
          }
        }

        return Container(
          decoration: BoxDecoration(
              color: SourceColors.grey[2], borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}
