import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class FileDiff extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  FileDiff(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bodyRightViewModel.fileDiffDashboardOutput,
      builder: (context, snapshot) {
        String file = snapshot.data != null? snapshot.data : "";

        return FutureBuilder(
          initialData: [],
          future: _bodyRightViewModel.diff(file),
          builder: (context, snapshotGitOutput) {
            List<String> fileDiff = List();
            if (snapshotGitOutput.data is GitOutput) {
              GitOutput gitOutput = snapshotGitOutput.data;
              fileDiff = gitOutput.isSuccess() &&
                  gitOutput.lines != null &&
                  gitOutput.lines is List<String> ? gitOutput.lines: List<String>();
            }
            return Container(
              decoration: BoxDecoration(
                  color: SourceColors.grey[2],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Visibility(
                visible: fileDiff.isNotEmpty,
                replacement: Center(child: Text("No file selected",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    color: SourceColors.blue[2],
                    fontSize: 16.0,
                  ),
                )),
                child: Text(file,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    color: SourceColors.blue[2],
                    fontSize: 16.0,
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}
