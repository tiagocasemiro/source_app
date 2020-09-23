import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body_right_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_left_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/footer_right_dashboard.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/header_dashboard.dart';
import 'package:source_app/engine/ui/widgets/horizontal_split_view.dart';
import 'package:source_app/engine/ui/widgets/vertical_split_view.dart';


class Dashboard extends StatelessWidget {
  final double _leftRation = 0.25;
  final double _minLeftRation = 0.20;
  final BodyLeftViewModel _bodyLeftViewModel = BodyLeftViewModel();
  final HeaderViewModel _headerViewModel = HeaderViewModel();

  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
      themeData: LoadingThemeData(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        animDuration: Duration(seconds: 1),
        loadingBackgroundColor: SourceColors.grey[5],
      ),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(defaultPaddingSize),
          color: SourceColors.grey[6],
          child: Column(
            children: [
              LayoutBuilder( builder: (context, BoxConstraints constraints) {
                return  Container(
                  height: 100,
                  width: constraints.maxWidth - defaultDivisorSize,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: _leftRation * (constraints.maxWidth - defaultDivisorSize),
                        height: 150,
                        child: Image.asset("images/source-logo.png"),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(defaultPaddingSize),
                          child: HeaderDashboard(_headerViewModel),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Expanded(
                child: VerticalSplitView(
                  minRatio: _minLeftRation,
                  ratio: _leftRation,
                  left: Container(
                    height: double.maxFinite,
                    margin: const EdgeInsets.only(left: defaultPaddingSize, top: defaultPaddingSize),
                    child:  BodyLeftDashboard(_bodyLeftViewModel),
                  ),
                  right: Container(
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
