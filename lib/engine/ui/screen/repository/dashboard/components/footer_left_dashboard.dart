import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class FooterLeftDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SourceColors.grey[2],
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}