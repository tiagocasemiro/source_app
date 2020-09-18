
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class MenuCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          hoverColor: SourceColors.blue[4],
          focusColor: SourceColors.blue[4],
          splashColor: SourceColors.blue[5],
          child: Container(
            margin: EdgeInsets.only(right: 16),
            child: Column(children: [
              Image.asset("images/ic_menu_close.png", width: 40, height: 40),
              Container(height: 5,),
              Text( "close", style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: SourceColors.blue[2],
                fontSize: 16.0,
                ),)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
      )
    );
  }
}
