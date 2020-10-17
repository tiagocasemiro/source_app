import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class HistoryDashboard extends StatelessWidget {

  final BodyRightViewModel _bodyRightViewModel;

  HistoryDashboard(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    var _style = GoogleFonts.balooBhai(
      fontWeight: FontWeight.w400,
      color: SourceColors.blue[2],
      fontSize: 18.0,
    );

    return Container(
      decoration: BoxDecoration(
        color: SourceColors.grey[2],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        decoration: BoxDecoration(
            color: SourceColors.grey[5],
            borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.only(left: 35, bottom: 1, top: 1),
        margin: EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        child: Column(
          children: [
            Row(
              children: [
                Text("_file", style: _style),
                Text("Tree", style: _style),
                Text("Hash", style: _style),
                Text("Message", style: _style),
                Text("Author", style:_style),
                Text("Date", style: _style)
              ],
            ),

          ],
        )
      ),
    );
  }
}