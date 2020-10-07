import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineFile extends StatelessWidget {
  final int _number;
  final String _content;

  ItemLineFile(this._number, this._content);

  @override
  Widget build(BuildContext context) {
    Color background = SourceColors.grey[8];
    Color text = SourceColors.blue[2];

    if(_content.startsWith("+")) {
      background = SourceColors.green[2];
      text = SourceColors.green;
    } else if (_content.startsWith("-")) {
      background = SourceColors.red[2];
      text = SourceColors.red;
    }


    return Row(children: [
      Container(
        color: SourceColors.grey[5],
        height: 30,
        width: 30,
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
              height: 29,
              padding: EdgeInsets.all(5),
              color: background,
              alignment: Alignment.centerLeft,
              child: Text(_content, style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
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
