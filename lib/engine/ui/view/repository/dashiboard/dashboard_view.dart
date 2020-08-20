
import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/view/widgets/horizontal_split_view.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: SourceColors.white,
      child: HorizontalSplitView(
        up: Container(
          color: SourceColors.blue,
        ),
        down: Container(
          color: SourceColors.black,
        ),
      ),
    );
  }
}
