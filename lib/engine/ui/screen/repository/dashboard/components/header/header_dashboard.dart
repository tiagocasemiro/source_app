import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/header/menu_close.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class HeaderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SourceColors.grey[2],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(child: Container(),),
          MenuCloseButton(),
        ],
      ),
    );
  }
}
