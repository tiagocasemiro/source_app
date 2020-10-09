import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';

class CommitDashboard extends StatelessWidget {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final BodyRightViewModel _bodyRightViewModel;

  CommitDashboard(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    Widget commitButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text("commit",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        commit(context);
      },
    );
    Widget cancelButton = RaisedButton(
      color: SourceColors.grey[5],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text("cancel",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        _bodyRightViewModel.displayHistory();
      },
    );

    return Container(
      decoration: BoxDecoration(
        color: SourceColors.grey[2],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: SourceColors.grey[5],
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.only(left: 35, bottom: 1, top: 1),
              margin: EdgeInsets.only(bottom: 8),
              width: double.maxFinite,
              child: Text("Message", style: GoogleFonts.balooBhai(
                fontWeight: FontWeight.w400,
                color: SourceColors.blue[2],
                fontSize: 18.0,
              ),),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: SourceColors.grey[8],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: SourceColors.grey[5], width: 1)
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: SourceColors.blue[2],
                      enableInteractiveSelection: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inform the message of commit';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 20,
                        color: SourceColors.blue[2],
                      ),
                      decoration: InputDecoration(
                      hoverColor: SourceColors.white,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(),),
                SizedBox(
                    width: 100,
                    height: 35,
                    child: cancelButton
                ),
                Container(width: 8,),
                SizedBox(
                    width: 100,
                    height: 35,
                    child: commitButton
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void commit(BuildContext context) {
    if(_formKey.currentState.validate()) {
      String message = _nameController.text;
      Load.show();
      _bodyRightViewModel.commit(message).then((GitOutput gitOutput) {
        Load.hide();
        if(gitOutput.isFailure()) {
          GitOutputErrorAlert(context).displayAlert(gitOutput.message);
        } else {
          Notify(context).showSuccessWithMessage(gitOutput);
          _bodyRightViewModel.displayHistory();
        }
      });
    }
  }
}