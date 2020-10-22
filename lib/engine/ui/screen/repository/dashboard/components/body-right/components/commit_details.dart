import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/commit_details_description.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/commit_details_files.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';

class CommitDetails extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;

  CommitDetails(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> titles_1 = <int, Widget>{
      0: Container(child: Text("Files", style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.blue[2],
        fontSize: 16.0,
      ))),
      1: Container(child: Text("Commit", style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.white,
        fontSize: 16.0,
      )))
    };
    Map<int, Widget> titles_2 = <int, Widget>{
      0: Container(child: Text("Files", style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.white,
        fontSize: 16.0,
      ))),
      1: Container(child: Text("Commit", style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: SourceColors.blue[2],
        fontSize: 16.0,
      )))
    };
    Map<int, Widget> selectedTitle = titles_2;
    int selectedValue = 0;

    return StreamBuilder(
      stream: _bodyRightViewModel.commitDetailsOutput,
      builder: (context, snapshot) {
        GitCommit commitDetails = snapshot.data;
        final CommitDetailsFiles commitDetailsFiles = CommitDetailsFiles(_bodyRightViewModel, commitDetails);
        final CommitDetailsDescription commitDetailsDescription = CommitDetailsDescription(_bodyRightViewModel, commitDetails);
        final Map<int, Widget> widgets = <int, Widget>{
          0: commitDetailsFiles,
          1: commitDetailsDescription
        };
        return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: SourceColors.grey[2],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: SourceColors.grey[5],
                                borderRadius: BorderRadius.circular(5)
                            ),
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(4),
                            width: double.maxFinite,
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 10,
                                      child: Container()
                                  ),
                                  Flexible(
                                    flex: 20,
                                    child: Container(
                                      width: 400,
                                      height: 28,
                                      child: CupertinoSegmentedControl<int>(
                                        borderColor: SourceColors.grey[5],
                                        selectedColor: SourceColors.grey[12],
                                        unselectedColor: SourceColors
                                            .grey[13],
                                        pressedColor: SourceColors.grey[13],
                                        children: selectedTitle,
                                        onValueChanged: (int value) {
                                          setState(() {
                                            if (value == 0) {
                                              selectedTitle = titles_2;
                                            } else {
                                              selectedTitle = titles_1;
                                            }
                                            selectedValue = value;
                                          });
                                        },
                                        groupValue: selectedValue,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 10,
                                      child: Container()
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: widgets[selectedValue]
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              );
            }
        );
      }
    );
  }
}
