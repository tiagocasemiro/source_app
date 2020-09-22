import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class Notify {
  BuildContext context;
  Duration _duration = Duration(seconds: 2);
  final String _defaultMessage =  "Command successfully executed";
  static  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _current;

  Notify(this.context);

  void showSuccessWithMessage(GitOutput gitOutput) {
    String message = gitOutput != null && gitOutput.message != null && gitOutput.message.isNotEmpty ? gitOutput.message.trim() : _defaultMessage;
    breakCurrent();
    _current = Scaffold.of(context).showSnackBar(_buildSuccessSnackBar(message));
  }

  void showDefaultSuccess() {
    breakCurrent();
    _current = Scaffold.of(context).showSnackBar(_buildSuccessSnackBar(_defaultMessage));
  }

  void showWarning(String message) {
    breakCurrent();
    _current = Scaffold.of(context).showSnackBar(_buildWarningSnackBar(message));
  }

  void breakCurrent() {
    if (_current != null) {
      try {
        _current.close();
      } catch(e) {}
    }
  }

  SnackBar _buildWarningSnackBar(String message) {
    return SnackBar(
      duration: _duration,
      content: Container(
        child: Text(message, style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          color: SourceColors.white,
          fontSize: 18.0, ),
        ),
      ),
      backgroundColor: SourceColors.orange,
    );
  }

  SnackBar _buildSuccessSnackBar(String message) {
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