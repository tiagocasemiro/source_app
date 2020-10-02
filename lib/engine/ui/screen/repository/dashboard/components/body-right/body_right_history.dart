import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_left_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_right_dashboard.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';

class BodyRightHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalSplitView(
        ratio: 0.60,
        up: Container(
          padding: const EdgeInsets.only(right: defaultPaddingSize, top: defaultPaddingSize),
          child: BodyRightDashboard(),
        ),
        down: Container(
          child: FooterDashboard(
            VerticalSplitView(
              left: Container(
                padding: const EdgeInsets.only(bottom: defaultPaddingSize),
                child: FooterLeftDashboard(),
              ),
              right: Container(
                padding: const EdgeInsets.only(right: defaultPaddingSize, bottom: defaultPaddingSize),
                child: FooterRightDashboard(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
