import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_dashboard.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';

class BodyRightCommit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalSplitView(
        ratio: 0.70,
        up: Container(
          padding: const EdgeInsets.only(top: defaultPaddingSize),
          child: VerticalSplitView(
            left: Container(
              padding: const EdgeInsets.only(),
              child: Container(color: SourceColors.grey,),
            ),
            right: Container(
              padding: const EdgeInsets.only(right: defaultPaddingSize),
              child: Container(color: SourceColors.grey,),
            ),
          ),
        ),
        down: Container(
          padding: const EdgeInsets.only(right: defaultPaddingSize, bottom: defaultPaddingSize),
          child: FooterDashboard(
            Container(
              color: SourceColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
