import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class GitOutputSuccessSnackBar {
  BuildContext context;
  final String _defaultMessage =  "Command successfully executed";

  GitOutputSuccessSnackBar(this.context);

  void showWithMessage(GitOutput gitOutput) {
    String message = gitOutput != null && gitOutput.message != null && gitOutput.message.isNotEmpty ? gitOutput.message.trim() : _defaultMessage;

    Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: Text(message, style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: SourceColors.white,
            fontSize: 18.0, ),
          ),
          backgroundColor: SourceColors.green,
        )
    );
  }

  void showDefaultMessage() {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: Text(_defaultMessage, style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: SourceColors.white,
            fontSize: 18.0, ),
          ),
          backgroundColor: SourceColors.green,
        )
    );
  }
}