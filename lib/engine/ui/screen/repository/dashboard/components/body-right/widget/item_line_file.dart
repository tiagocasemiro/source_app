import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineFile extends StatelessWidget {
  final int _number;
  final String _content;
  final String _file;

  ItemLineFile(this._number, this._content, this._file);

  @override
  Widget build(BuildContext context) {
    Color background = SourceColors.grey[8];
    Color text = SourceColors.blue[2];

    if(_content.startsWith("+")) {
      background = SourceColors.green[2];
      text = SourceColors.green[3];
    } else if (_content.startsWith("-")) {
      background = SourceColors.red[2];
      text = SourceColors.red;
    }

    if(_number == 0) {
      return Container(
        decoration: BoxDecoration(
            color: SourceColors.grey[5],
            borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.only(left: 35, bottom: 1, top: 1),
        margin: EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        child: Text(_file, style: GoogleFonts.balooBhai(
          fontWeight: FontWeight.w400,
          color: SourceColors.blue[2],
          fontSize: 18.0,
        ),),
      );
    }

    return Row(children: [
      Container(
        color: SourceColors.grey[5],
        height: 33,
        width: 33,
        child: Center(
          child: Text(_number.toString(), style: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            color: SourceColors.blue[2],
            fontSize: 16.0,
          ),),
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Container(
              height: 32,
              padding: EdgeInsets.all(5),
              color: background,
              alignment: Alignment.centerLeft,
              child: Text(_content, style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: text,
                fontSize: 16.0,
              ),),
            ),
            Container(height: 1,)
          ],
        ),
      ),
    ],);
  }
}
