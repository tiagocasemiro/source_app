import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load/load.dart';
import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';

class PullAlert {
  final HeaderViewModel _headerViewModel;
  GitBranch _selectedBranch;
  PullAlert(this._headerViewModel);

  displayAlert(BuildContext context) {
    Load.show();
    _headerViewModel.remoteBranches().then((GitOutput gitOutput){
      Load.hide();
      if(gitOutput.isSuccess()) {
        List<GitBranch> _branches = gitOutput.object as List<GitBranch>;
        Widget content = createContent(context, _branches);
        _display(context, content);
      } else {
        GitOutputErrorAlert(context).displayAlert(gitOutput.message);
      }
    });
  }

  void _display(BuildContext context, Widget content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingProvider(
            themeData: LoadingThemeData(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              animDuration: Duration(seconds: 1),
              loadingBackgroundColor: SourceColors.grey[5],
            ),
            child: content);
      },
      barrierDismissible: false,
    );
  }

  Widget  createContent(BuildContext context, List<GitBranch> branches) {
    _selectedBranch = null;
    Widget createButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("pull",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        pull(context);
      },
    );
    Widget cancelButton = RaisedButton(
      color: SourceColors.grey[5],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("cancel",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    StatefulBuilder alertDialog = StatefulBuilder(
        builder: (context, setState) {
          return  AlertDialog(
            title: Text("Pull",
              style: GoogleFonts.balooBhai(
                fontWeight: FontWeight.w300,
                color: SourceColors.blue[2],
                fontSize: 25.0,
              ),
            ),
            actionsPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Container(
              width: 750,
              height: 350,
              child: Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text("Other remote branchs",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: SourceColors.blue[2],
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final GitBranch branch = branches[index];
                          return ListTile(
                            title: Text(branch.fullName(),
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: SourceColors.blue[2],
                                fontSize: 16.0,
                              ),
                            ),
                            leading: Radio(
                              value: branch,
                              groupValue: _selectedBranch,
                              onChanged: (branch) {
                                setState((){
                                  _selectedBranch = branch;
                                });
                              },
                            ),
                          );
                        },
                        itemCount: branches.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              SizedBox(
                width: 150,
                height: 40,
                child: cancelButton,
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: createButton,
              ),
            ],
          );
        });

    return alertDialog;
  }

  void pull(BuildContext context) async {
    Load.show();
    GitOutput gitOutput = await _headerViewModel.pull(_selectedBranch);
    Load.hide();
    if(gitOutput.isFailure()) {
      GitOutputErrorAlert(context).displayAlert(gitOutput.message);
    } else {
      Notify(context).showSuccessWithMessage(gitOutput);
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  }
}