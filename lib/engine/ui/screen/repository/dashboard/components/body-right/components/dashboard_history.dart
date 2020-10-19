import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/widget/item_history.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class HistoryDashboard extends StatelessWidget {

  final BodyRightViewModel _bodyRightViewModel;

  HistoryDashboard(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    var _style = GoogleFonts.balooBhai(
      fontWeight: FontWeight.w400,
      color: SourceColors.blue[2],
      fontSize: 18.0,
    );
    _bodyRightViewModel.history();

    return Container(
      decoration: BoxDecoration(
        color: SourceColors.grey[2],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: SourceColors.grey[5],
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: 35, bottom: 1, top: 1),
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text("_file", style: _style),
                  Text("Tree", style: _style),
                  Text("Hash", style: _style),
                  Text("Message", style: _style),
                  Text("Author", style:_style),
                  Text("Date", style: _style),
                ],
              ),
            ),
            StreamBuilder(
              stream: _bodyRightViewModel.historyCommitOutput,
              builder: (context, snapshot) {
                GitOutput gitOutput = snapshot.data;
                List<GitCommit> commits = snapshot.data is GitOutput &&
                    gitOutput.isSuccess() && gitOutput.object != null &&
                    gitOutput.object is List<GitCommit> ? gitOutput.object: List<GitCommit>();

                return Visibility(
                  visible: commits.isNotEmpty,
                  replacement: Center(child: Text("No history",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: SourceColors.blue[2],
                      fontSize: 16.0,
                    ),
                  )),
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final GitCommit commit = commits[index];
                          return ItemHistory(index, commit, (String hash) {
                            print(hash);
                          });
                        },
                        itemCount: commits.length,
                      ),
                    ),
                  ),
                );
              },),
          ],
        )
      ),
    );
  }
}