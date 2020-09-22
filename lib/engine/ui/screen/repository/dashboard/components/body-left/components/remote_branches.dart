import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';


class RemoteBranches extends StatefulWidget {
  final BodyLeftViewModel _dashboardViewModel;

  RemoteBranches(this._dashboardViewModel);

  @override
  _RemoteBranchesState createState() => _RemoteBranchesState(_dashboardViewModel);
}

class _RemoteBranchesState extends State<RemoteBranches> {
  final BodyLeftViewModel _dashboardViewModel;

  _RemoteBranchesState(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    print("load remote branches");
    return Theme(
      data: theme,
      isMaterialAppTheme: true,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: SourceColors.grey[2],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.only(right: 0, top: 0, left: 0, bottom: 16),
            title: Container(
              height: 32,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title:Align(
                  child: Transform(
                    transform: Matrix4.translationValues(-26, -8, 0.0),
                    child: Text("Branch remote", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: SourceColors.blue[2],
                      fontSize: 16.0,
                    ),),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                leading: Transform(
                    transform: Matrix4.translationValues(-0, -8, 0.0),
                    child: Image.asset("images/branch-remote.png", width: 16, height: 16)
                ),
              ),
            ),
            children: <Widget>[
              FutureBuilder(
                initialData: [],
                future: _dashboardViewModel.remoteBranches(),
                builder: (context, snapshot) {
                  List<GitBranch> branches = List<GitBranch>();
                  if (snapshot.data is GitOutput) {
                    GitOutput gitOutput = snapshot.data;
                    branches = gitOutput.isSuccess() &&
                      gitOutput.object != null &&
                      gitOutput.object is List<GitBranch> ? gitOutput.object: List<GitBranch>();
                  }

                  return Visibility(
                    visible: branches.isNotEmpty,
                    replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No branches", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: SourceColors.blue[2],
                      fontSize: 14.0,
                    ),)),
                    child: Column(
                      children: _buildExpandableContent(branches),
                    ),
                  );
                },
              ),
            ],
            trailing: Image.asset("images/down-indicator.png", width: 15.5, height: 8),
            initiallyExpanded: false,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandableContent(List<GitBranch> branches) {
    List<Widget> columnContent = [];
    String lastFolder = "";

    for (GitBranch branch in branches) {
      if(branch.hasFolder() && lastFolder != branch.folder()) {
        lastFolder = branch.folder();
        columnContent.add(_buildFolder(branch.folder()));
      }
      columnContent.add(_buildBranch(branch));
    }
    return columnContent;
  }

  Widget _buildFolder(String name) {
    return Container(
      height: 32,
      child: Transform(
        transform: Matrix4.translationValues(0, -8, 0),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
              left: 32, bottom: 0, top: 0, right: 0),
          title: Align(
            child: Transform(
              transform: Matrix4.translationValues(-32, 0.0, 0.0),
              child: Text(name, style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SourceColors.blue[2],
                fontSize: 16.0,
              ),),
            ),
            alignment: Alignment.centerLeft,
          ),
          leading: Transform(
              transform: Matrix4.translationValues(0, 4, 0.0),
              child: Image.asset("images/ic-folder.png", width: 12, height: 10,)
          ),
        ),
      ),
    );
  }

  Widget _buildBranch(GitBranch branch) {
    double leftPadding = branch.hasFolder() ? 32 : 16;
    TextStyle currentBranche = GoogleFonts.balooBhai(
      fontWeight: FontWeight.w400,
      color: SourceColors.blue[2],
      fontSize: 18.0,
    );
    TextStyle allBranches = GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      color: SourceColors.blue[2],
      fontSize: 16.0,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          hoverColor: SourceColors.blue[4],
          focusColor: SourceColors.blue[4],
          splashColor: SourceColors.blue[5],
          child: Container(
            height: 32,
            child: Transform(
              transform: Matrix4.translationValues(0, -8, 0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: leftPadding, bottom: 0, top: 0, right: 0),
                title: Align(
                  child: Transform(
                    transform: Matrix4.translationValues(-32, 0.0, 0.0),
                    child: Text(branch.pureName(),
                      style: branch.current ? currentBranche : allBranches,
                      maxLines: 1,),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                leading: RotatedBox(quarterTurns: 3,
                    child: Image.asset(
                        "images/down-indicator.png", width: 15.5, height: 8)),
                mouseCursor: SystemMouseCursors.click,
              ),
            ),
          ),
          onDoubleTap: () {
            Load.show();
            _dashboardViewModel.checkoutRemoteBranch(branch.name).then((GitOutput gitOutput) {
              if(gitOutput.isFailure()) {
                GitOutputErrorAlert(context).displayAlert(gitOutput);
              } else {
                Notify(context).showSuccessWithMessage(gitOutput);
              }
              Load.hide();
            }, onError: (e) => Load.hide());
          },
        ),
      ),
    );
  }
}
