
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class AddLocalRepository {
  final _nameController = TextEditingController();
  final _workDirController = TextEditingController();

  displayAlert(BuildContext context) {
    Widget createButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("Create",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        if (_validateNewRepo()) {
          saveRepository();
          Navigator.of(context, rootNavigator: true).pop('dialog');
        }
      },
    );
    Widget cancelButton = RaisedButton(
      color: SourceColors.grey[5],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("Cancel",
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
      title: Text("New repository",
        style: GoogleFonts.balooBhai(
          fontWeight: FontWeight.w300,
          color: SourceColors.blue[2],
          fontSize: 25.0,
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        width: 500,
        height: 150,
        child: Container(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: SourceColors.blue[6],
                        width: 2.5
                    )
                ),
                child: TextFormField(
                  controller: _nameController,
                  cursorColor: SourceColors.blue[2],
                  autofocus: true,
                  decoration: InputDecoration(
                      fillColor: SourceColors.grey,
                      focusColor: SourceColors.blue[3],
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Name',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: SourceColors.blue[6]
                      )
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: SourceColors.blue[6],
                        width: 2.5
                    )
                ),
                child: TextFormField(
                  controller: _workDirController,
                  cursorColor: SourceColors.blue[2],
                  decoration: InputDecoration(
                      fillColor: SourceColors.grey,
                      focusColor: SourceColors.blue[3],
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Work directory',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: SourceColors.blue[6]
                      )
                  ),
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
      barrierDismissible: false,
    );
  }

  bool _validateNewRepo() {

    return true;
  }

  void saveRepository() {

  }
}