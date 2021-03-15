import 'package:bot_toast/bot_toast.dart';
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


class LocalBranches extends StatefulWidget {
  final BodyLeftViewModel _bodyLeftViewModel;

  LocalBranches(this._bodyLeftViewModel);

  @override
  _LocalBranchesState createState() => _LocalBranchesState(_bodyLeftViewModel);
}

class _LocalBranchesState extends State<LocalBranches> {
  final BodyLeftViewModel _dashboardViewModel;

  _LocalBranchesState(this._dashboardViewModel);

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
                    child: Text("Branch local", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: SourceColors.blue[2],
                      fontSize: 16.0,
                    ),),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                leading: Transform(
                  transform: Matrix4.translationValues(-0, -8, 0.0),
                  child: Image.asset("images/branch-local.png", width: 16, height: 16)
                ),
              ),
            ),
            children: <Widget>[
              FutureBuilder(
                initialData: [],
                future: _dashboardViewModel.localBranches(),
                builder: (context, snapshot) {
                  List<GitBranch> branches = <GitBranch>[];
                  if (snapshot.data is GitOutput) {
                    GitOutput gitOutput = snapshot.data;
                    branches = gitOutput.isSuccess() &&
                      gitOutput.object != null &&
                      gitOutput.object is List<GitBranch> ? gitOutput.object: <GitBranch>[];
                  }

                  return Visibility(
                    visible: branches.isNotEmpty,
                    replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No branches", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: SourceColors.blue[2],
                      fontSize: 14.0,
                    ),)),
                    child: new Column(
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

  _buildExpandableContent(List<GitBranch> branches) {
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

  Widget _contextMenu(Widget widget) {
    return Builder(
        builder: (ctx) {
          return GestureDetector(
            child: widget,
            onSecondaryTap: () {
              show(context: ctx);
            },
          );
        }
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

    return _contextMenu(Container(
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
                    child: Text(branch.pureName(), style: branch.current ? currentBranche : allBranches, maxLines: 1,),
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
            if(!branch.current) {
              Load.show();
              _dashboardViewModel.checkoutLocalBranch(branch.name).then((GitOutput gitOutput) {
                Load.hide();
                if (gitOutput.isFailure()) {
                  GitOutputErrorAlert(context).displayAlert(gitOutput.message);
                } else {
                  Notify(context).showSuccessWithMessage(gitOutput);
                }
              }, onError: (e) => Load.hide());
            } else {
              Notify(context).showWarning("The branch " + branch.name + ", is the current");
            }
          },
          onTap: () {
            _dashboardViewModel.displayHistoty();
          },
        ),
      ),
    ));
  }



  CancelFunc show({BuildContext context, Offset target}) {
    return BotToast.showAttachedWidget(
        attachedBuilder: (_) => Card(
          color:  SourceColors.white,
          child: _menu(),
        ),
        animationDuration: Duration(milliseconds: 300),
        enableSafeArea: false,
        targetContext: context,
        preferDirection: PreferDirection.bottomCenter
    );
  }

  Widget _menu() {
    TextStyle allBranches = GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      color: SourceColors.blue[2],
      fontSize: 16.0,
    );

    return  Card(
      color: SourceColors.white,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // todo impplement delete local branch
                BotToast.cleanAll();
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 70, maxWidth: 140),
                child: Row(children: [
                  Icon(Icons.delete, color: SourceColors.blue[2]),
                  Text('delete', style: allBranches,),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
