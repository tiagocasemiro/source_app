import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class GitOutputErrorAlert {
  final BuildContext context;
  GitOutputErrorAlert(this.context);

  displayAlert(String message) {
    Widget closeButton = RaisedButton(
      color: SourceColors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("close",
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

    AlertDialog alertDialog = AlertDialog(
      title: Text("Terminal output error",
        style: GoogleFonts.balooBhai(
          fontWeight: FontWeight.w300,
          color: SourceColors.red,
          fontSize: 25.0,
        ),
      ),
      backgroundColor: SourceColors.grey[7],
      actionsPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        width: 650,
        child: Text(message, style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: SourceColors.blue[2],
          fontSize: 16.0,
        ),),
      ),
      actions: [
        SizedBox(
          width: 150,
          height: 40,
          child: closeButton,
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
      barrierDismissible: false,
    );
  }
}