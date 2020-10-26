import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/widget/item_file_commited.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class CommitDetailsFiles extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;
  final GitCommit _commitDetails;

  CommitDetailsFiles(this._bodyRightViewModel, this._commitDetails);

  @override
  Widget build(BuildContext context) {
    GitOutput initialData = GitOutput("").withObject( List<GitFileModified>());
    return FutureBuilder(
      initialData: initialData,
      future: _bodyRightViewModel.modifiedFilesFromCommit(_commitDetails),
      builder: (context, snapshot) {
        GitOutput gitOutput = snapshot.data;
        List<GitFileModified> filesCommitted = snapshot.data is GitOutput &&
          gitOutput.isSuccess() && gitOutput.object != null &&
          gitOutput.object is List<GitFileModified> ? gitOutput.object: List<GitFileModified>();

        if(snapshot.connectionState == ConnectionState.done && filesCommitted != null && filesCommitted.isNotEmpty) {
          GitFileModified fileCommitted = filesCommitted[0];
          fileCommitted.stageFile = StageFile.committed;
          _bodyRightViewModel.displayFileDiff(fileCommitted);
        }

        return Visibility(
          visible: filesCommitted.isNotEmpty,
          replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No files on commit",
           style: GoogleFonts.roboto(
             fontWeight: FontWeight.w300,
             color: SourceColors.blue[2],
             fontSize: 16.0,
           ),
          )),
          child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final GitFileModified fileCommitted = filesCommitted[index];
                fileCommitted.beforeCommitHash = _commitDetails.beforeHash.trim();

                return ItemFileCommitted(_bodyRightViewModel, fileCommitted);
              },
              itemCount: filesCommitted.length,
            ),
          )
        );
      }
    );
  }
}
