import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class MenuButton extends StatelessWidget {
  final String _label;
  final String _icon;
  final GestureTapCallback _onTap;

  MenuButton(this._label, this._icon, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: [
        Stack(children: [
          Image.asset(_icon, width: 36, height: 36),
          Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                hoverColor: SourceColors.blue[4],
                focusColor: SourceColors.blue[4],
                splashColor: SourceColors.blue[5],
                child: Container(height: 36, width: 36,),
                onTap: _onTap,
              )
          ),
        ],),
        Container(height: 5,),
        Text( _label, style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: SourceColors.blue[2],
          fontSize: 14.5, ),
        )],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
