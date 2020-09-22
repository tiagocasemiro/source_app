import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class GitOutputSuccessSnackBar {
  BuildContext context;
  Duration _duration = Duration(seconds: 2);
  final String _defaultMessage =  "Command successfully executed";
  static  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> current;

  GitOutputSuccessSnackBar(this.context);

  void showWithMessage(GitOutput gitOutput) {
    String message = gitOutput != null && gitOutput.message != null && gitOutput.message.isNotEmpty ? gitOutput.message.trim() : _defaultMessage;
    breakCurrent();
    current = Scaffold.of(context).showSnackBar(_buidSnackBar(message));
  }

  void showDefaultMessage() {
    breakCurrent();
    current = Scaffold.of(context).showSnackBar(_buidSnackBar(_defaultMessage));
  }

  void breakCurrent() {
    if (current != null) {
      try {
        current.close();
      } catch(e) {}
    }
  }

  SnackBar _buidSnackBar(String message) {
    return SnackBar(
      duration: _duration,
      content: Container(
        child: Text(message, style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          color: SourceColors.white,
          fontSize: 18.0, ),
        ),
      ),
      backgroundColor: SourceColors.green,
    );
  }
}