import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class CommitDetailsDescription extends StatelessWidget {
  // ignore: unused_field
  final BodyRightViewModel _bodyRightViewModel;
  final GitCommit _commitDetails;
  final TextStyle _styleLabel = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    color: SourceColors.blue[2],
    fontSize: 16.0,
  );
  final TextStyle _styleContent = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    color: SourceColors.blue[2],
    fontSize: 16.0,
  );
  final double withLabel = 70;

  CommitDetailsDescription(this._bodyRightViewModel, this._commitDetails);

  @override
  Widget build(BuildContext context) {
    String message = _commitDetails != null ? _commitDetails.message : "No message on this commit";
    String author = _commitDetails != null ? _commitDetails.author : "";
    String hash = _commitDetails != null ? _commitDetails.abbreviatedHash : "";
    String date = _commitDetails != null ? _commitDetails.date : "";


    return SingleChildScrollView(
      child: Visibility(
        visible: _commitDetails != null,
        replacement: Center(child: Text("No commit selected", style: _styleLabel,),),
        child: Container(
          padding: EdgeInsets.all(4),
          child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              color: SourceColors.grey[10],
              child: Row(
                children: [
                  Container(
                    child: Text("Author:", style: _styleLabel, textAlign: TextAlign.end,),
                    width: withLabel,
                    margin: EdgeInsets.only(right: 4),
                  ),
                  Expanded(child: Text(author, style: _styleContent,)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              color: SourceColors.grey[11],
              child: Row(
                children: [
                  Container(
                    child: Text("Date:", style: _styleLabel, textAlign: TextAlign.end,),
                    width: withLabel,
                    margin: EdgeInsets.only(right: 4),
                  ),
                  Expanded(child: Text(date, style: _styleContent,)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              color: SourceColors.grey[10],
              child: Row(
                children: [
                  Container(
                    child: Text("Hash:", style: _styleLabel, textAlign: TextAlign.end,),
                    width: withLabel,
                    margin: EdgeInsets.only(right: 4),
                  ),
                  Expanded(child: Text(hash, style: _styleContent,)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              color: SourceColors.grey[11],
              child: Row(
                children: [
                  Container(
                    child: Text("Message:", style: _styleLabel, textAlign: TextAlign.end,),
                    width: withLabel,
                    margin: EdgeInsets.only(right: 4),
                  ),
                  Expanded(child: Text(message, style: _styleContent,)),
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
