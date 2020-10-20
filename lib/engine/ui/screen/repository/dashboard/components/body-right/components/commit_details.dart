import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/widget/item_file_from_commit.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';

class CommitDetails extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;
  final Map<int, Widget> titles = const <int, Widget>{ 0: Text("Files"), 1: Text("Commit") };

  CommitDetails(this._bodyRightViewModel);

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> widgets = <int, Widget>{
      0: ItemFileFromCommit(_bodyRightViewModel),
      1: Container()
    };
    int selectedValue = 0;

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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: double.maxFinite,
                    child: CupertinoSegmentedControl<int>(
                      children: titles,
                      onValueChanged: (int value) {
                        setState((){
                          selectedValue = value;
                        });
                      },
                      groupValue: selectedValue,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      child: Container()
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
}
