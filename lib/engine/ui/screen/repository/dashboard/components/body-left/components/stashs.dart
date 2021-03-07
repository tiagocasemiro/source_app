import 'package:source_app/engine/domain/model/git_stash.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';


class StashDashboard extends StatefulWidget {
  final BodyLeftViewModel _dashboardViewModel;

  StashDashboard(this._dashboardViewModel);

  @override
  _StashState createState() => _StashState(_dashboardViewModel);
}

class _StashState extends State<StashDashboard> {
  final BodyLeftViewModel _dashboardViewModel;

  _StashState(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
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
                    child: Text("Stash", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: SourceColors.blue[2],
                      fontSize: 16.0,
                    ),),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                leading: Transform(
                    transform: Matrix4.translationValues(-0, -8, 0.0),
                    child: Image.asset("images/ic_stash.png", width: 16, height: 16)
                ),
              ),
            ),
            children: <Widget>[
              FutureBuilder(
                initialData: [],
                future: _dashboardViewModel.stashs(),
                builder: (context, snapshot) {
                  List<GitStash> stashes = <GitStash>[];
                  if (snapshot.data is GitOutput) {
                    GitOutput gitOutput = snapshot.data;
                    stashes = gitOutput.isSuccess() &&
                      gitOutput.object != null &&
                      gitOutput.object is List<GitStash> ? gitOutput.object : <GitStash>[];
                  }

                  return Visibility(
                    visible: stashes.isNotEmpty,
                    replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No stash", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: SourceColors.blue[2],
                      fontSize: 14.0,
                    ),)),
                    child: new Column(
                      children: _buildExpandableContent(stashes),
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

  _buildExpandableContent(List<GitStash> stashes) {
    List<Widget> columnContent = [];
    for (GitStash stash in stashes) {
      columnContent.add(_buildStash(stash));
    }
    return columnContent;
  }

  Widget _buildStash(GitStash stash) {
    TextStyle normalStyle = GoogleFonts.roboto(
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
                contentPadding: EdgeInsets.only(left: 16, bottom: 0, top: 0, right: 0),
                title: Align(
                  child: Transform(
                    transform: Matrix4.translationValues(-32, 0.0, 0.0),
                    child: Text(stash.name, style: normalStyle, maxLines: 1,),
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
            _dashboardViewModel.apply(stash).then((GitOutput gitOutput) {
              Load.hide();
              if(gitOutput.isFailure()) {
                GitOutputErrorAlert(context).displayAlert(gitOutput.message);
              } else {
                Notify(context).showSuccessWithMessage(gitOutput);
              }
            }, onError: (e) => Load.hide());
          },
        ),
      ),
    );
  }
}
