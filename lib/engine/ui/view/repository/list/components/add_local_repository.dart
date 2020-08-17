
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

// http://www.macoratti.net/19/06/flut_alertdi1.htm
addLocalRepositoryAlert (BuildContext context) {

  Widget createButton = RaisedButton(
    color: SourceColors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Text(
      "Create",
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.white,
        fontSize: 16.0,
      ),
    ),
    onPressed:  () {},
  );
  Widget cancelButton = RaisedButton(
    color: SourceColors.grey[5],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Text(
      "Cancel",
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.white,
        fontSize: 16.0,
      ),
    ),
    onPressed:  () {},
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text("Repository"),
    actionsPadding: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    content: Container(
      width: 500,
      height: 150,
      child: Center(
        child: Text("Content"),
      ),
    ),
    actions: [
      SizedBox(
        width: 120,
        height: 32,
        child: cancelButton,
      ),
      SizedBox(
        width: 120,
        height: 32,
        child: createButton,
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}