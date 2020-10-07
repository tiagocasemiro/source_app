import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class StagedFiles extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  StagedFiles(this._bodyRightViewModel);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        color: SourceColors.grey[2],
        borderRadius: BorderRadius.circular(10),        
      ),
      child: RaisedButton(
        color: SourceColors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text("create",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            color: SourceColors.white,
            fontSize: 18.0,
          ),
        ),
        onPressed: () {
          _bodyRightViewModel.displayFileDiff("documet_2.txt");
        },
      )
    );
  }
}
