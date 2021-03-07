import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/widget/item_file_check.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';

class UnstagedFiles extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  UnstagedFiles(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bodyRightViewModel.unStagedDashboardOutput,
      builder: (context, snapshot) {

        return FutureBuilder(
            initialData: [],
            future: _bodyRightViewModel.unStagedFiles(),
            builder: (context, snapshotGitOutput) {
              // ignore: deprecated_member_use
              List<String> filesUncommitted = List();
              filesUncommitted.add("");
              if (snapshotGitOutput.data is GitOutput) {
                GitOutput gitOutput = snapshotGitOutput.data;
                List<String> temp = gitOutput.isSuccess() &&
                    gitOutput.object != null &&
                    gitOutput.object is List<String> ? gitOutput.object: <String>[];
                filesUncommitted.addAll(temp);
              }

              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: SourceColors.grey[2],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Visibility(
                  visible: filesUncommitted.isNotEmpty,
                  replacement: Center(child: Text("No file to add",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: SourceColors.blue[2],
                      fontSize: 16.0,
                    ),
                  )),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final String file = filesUncommitted[index];

                      return ItemLineCheck(file, index, "Unstaged files", (String checkedFile) {
                        _bodyRightViewModel.add(checkedFile).then((GitOutput gitOutput) {
                          if(gitOutput.isFailure()) {
                            GitOutputErrorAlert(context).displayAlert(gitOutput.message);
                          }
                        });
                      }, (String clickedFile) {
                        GitFileModified fileModified = GitFileModified(clickedFile, stageFile: StageFile.unstaged);
                        _bodyRightViewModel.displayFileDiff(fileModified);
                      });
                    },
                    itemCount: filesUncommitted.length,
                  ),
                ),
              );
            }
        );
      },
    );
  }
}
