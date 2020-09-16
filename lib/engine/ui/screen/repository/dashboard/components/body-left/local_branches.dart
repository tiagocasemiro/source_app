import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class LocalBranches extends StatefulWidget {
  final DashboardViewModel _dashboardViewModel;

  LocalBranches(this._dashboardViewModel);

  @override
  _LocalBranchesState createState() => _LocalBranchesState(_dashboardViewModel);
}

class _LocalBranchesState extends State<LocalBranches> {
  final DashboardViewModel _dashboardViewModel;

  _LocalBranchesState(this._dashboardViewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

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
            title: ListTile(
              contentPadding: const EdgeInsets.all(4),
              title:Align(
                child: Transform(
                  transform: Matrix4.translationValues(-26, 0.0, 0.0),
                  child: Text("Branches local", style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    color: SourceColors.blue[2],
                    fontSize: 16.0,
                  ),),
                ),
                alignment: Alignment.centerLeft,
              ),

              leading: Image.asset("images/branch-local.png", width: 16, height: 16),
            ),
            children: <Widget>[
              FutureBuilder(
                initialData: [],
                future: _dashboardViewModel.localBranches(),
                builder: (context, snapshot) {
                  final List<GitBranch> branches = snapshot.data is List<GitBranch> && snapshot.data != null? snapshot.data: List<GitBranch>();
                  return Visibility(
                    visible: branches.isNotEmpty,
                    replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No branches")),
                    child: new Column(
                      children: _buildExpandableContent(branches),
                    ),
                  );
                },
              ),
            ],
            trailing: Image.asset("images/down-indicator.png", width: 15.5, height: 8),
            initiallyExpanded: true,
          ),
        ),
      ),
    );
  }

  _buildExpandableContent(List<GitBranch> branches) {
    List<Widget> columnContent = [];

    for (GitBranch content in branches)
      columnContent.add(
        ListTile(
          contentPadding: const EdgeInsets.only(left: 32, bottom: 4, top: 4, right: 4),
          title: Align(
            child: Transform(
              transform: Matrix4.translationValues(-32, 0.0, 0.0),
              child: Text(content.name, style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                color: SourceColors.blue[2],
                fontSize: 16.0,
              ),),
            ),
            alignment: Alignment.centerLeft,
          ),
          leading: RotatedBox(quarterTurns: 3, child: Image.asset("images/down-indicator.png", width: 15.5, height: 8)),
        ),
      );

    return columnContent;
  }
}

