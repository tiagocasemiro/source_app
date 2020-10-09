import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineCheck extends StatelessWidget {
  final String _file;
  final int _index;
  final String _title;
  final Function _onCheck;
  final Function _onClick;


  ItemLineCheck(this._file, this._index, this._title, this._onCheck(String file), this._onClick(String file));

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

    return Container(
      height: 30,
      child: CheckboxListTile(
        title: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            hoverColor: SourceColors.blue[4],
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
              child: Text(_file,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: SourceColors.blue[2],
                  fontSize: 16.0,
                ),
              ),
            ),
            onTap: () {
              _onClick(_file);
            },
          ),
        ),
        value: _isChecked,
        onChanged: (newValue) {
          _onCheck(_file);
        },
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.only(right: 4, left: 4),
      ),
    );
  }
}
