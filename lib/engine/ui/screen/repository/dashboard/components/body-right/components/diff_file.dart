import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class FileDiff extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  FileDiff(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bodyRightViewModel.fileDiffDashboardOutput,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.data != null,
          replacement: Center(child: Text("No file",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              color: SourceColors.blue[2],
              fontSize: 16.0,
            ),
          )),
          child: Container(
            decoration: BoxDecoration(
                color: SourceColors.grey[2],
                borderRadius: BorderRadius.circular(10)
            ),
            child: Text(snapshot.data,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                  color: SourceColors.blue[2],
                  fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
