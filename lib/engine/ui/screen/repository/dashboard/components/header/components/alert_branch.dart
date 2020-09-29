import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load/load.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';

class NewBranchAlert {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final HeaderViewModel _headerViewModel;
  bool _switchToNewBranch = false;
  NewBranchAlert(this._headerViewModel);

  displayAlert(BuildContext context) {
    Widget createButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("create",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        create(context);
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
          title: Text("New branch",
            style: GoogleFonts.balooBhai(
              fontWeight: FontWeight.w300,
              color: SourceColors.blue[2],
              fontSize: 25.0,
            ),
          ),
          actionsPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Container(
            width: 550,
            height: 110,
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: _nameController,
                        cursorColor: SourceColors.blue[2],
                        enableInteractiveSelection: true,
                        autofocus: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Inform the name of new branch';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: SourceColors.blue[2],
                        ),
                        decoration: InputDecoration(
                          fillColor: SourceColors.grey,
                          focusColor: SourceColors.blue[3],
                          contentPadding: EdgeInsets.all(16),
                          labelText: 'Name',
                          hintStyle: GoogleFonts.roboto(
                            color: SourceColors.blue[2],
                            fontSize: 16,
                          ),
                          labelStyle: GoogleFonts.roboto(
                            fontSize: 20,
                            color: SourceColors.blue[2],
                            height: 0.8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            ),
                            borderSide: new BorderSide(
                              color: SourceColors.blue[6],
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: Text("Switch to new branch",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: SourceColors.blue[2],
                            fontSize: 16.0,
                          ),
                      ),
                      value: _switchToNewBranch,
                      onChanged: (newValue) {
                        setState(() {
                          _switchToNewBranch = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.platform,
                      contentPadding: EdgeInsets.only(right: 8, left: 16),
                    )
                  ],
                ),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingProvider(
            themeData: LoadingThemeData(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              animDuration: Duration(seconds: 1),
              loadingBackgroundColor: SourceColors.grey[5],
            ),
            child: alertDialog);
      },
      barrierDismissible: false,
    );
  }

  void create(BuildContext context) async {
    String name = _nameController.text;
    if(_formKey.currentState.validate()) {
      Load.show();
      GitOutput gitOutput;

      if(_switchToNewBranch) {
        gitOutput = await _headerViewModel.newBranchAndCheckout(name);
      } else {
        gitOutput = await _headerViewModel.newBranch(name);
      }

      Load.hide();
      if(gitOutput.isFailure()) {
        GitOutputErrorAlert(context).displayAlert(gitOutput.message);
      } else {
        Notify(context).showSuccessWithMessage(gitOutput);
        Navigator.of(context, rootNavigator: true).pop('dialog');
      }
    }
  }
}