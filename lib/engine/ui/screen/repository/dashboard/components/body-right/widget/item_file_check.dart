import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineCheck extends StatelessWidget {
  final String _file;
  final int _index;
  final String _title;
  final Function _callback;

  ItemLineCheck(this._file, this._index, this._title, this._callback(String file));

  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    if(_index == 0) {
      return Container(
        decoration: BoxDecoration(
          color: SourceColors.grey[5],
          borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.only(left: 35, bottom: 1, top: 1),
        margin: EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        child: Text(_title, style: GoogleFonts.balooBhai(
          fontWeight: FontWeight.w400,
          color: SourceColors.blue[2],
          fontSize: 18.0,
        ),),
      );
    }

    return CheckboxListTile(
      title: Text(_file,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: SourceColors.blue[2],
          fontSize: 16.0,
        ),
      ),
      value: _isChecked,
      onChanged: (newValue) {
        _callback(_file);
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.only(right: 8, left: 16),
    );
  }
}
