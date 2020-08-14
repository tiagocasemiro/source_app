

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/view/repository/list/list_repositories_viewmodel.dart';

import '../../../../source_resources.dart';

class RepositoryDetails extends StatelessWidget {
  final SelectRepositoryViewModel _viewModel;
  final String _content;

  RepositoryDetails(this._viewModel, this._content);

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(

            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$ git status\n",
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.w700,
                    color: SourceColors.blue[2],
                    fontSize: 25.0,
                  ),
                ),
                Text(_content,
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.w400,
                    color: SourceColors.blue[2],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
