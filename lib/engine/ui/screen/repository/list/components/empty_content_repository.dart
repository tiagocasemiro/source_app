import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/screen/repository/list/list_repositories_viewmodel.dart';

class EmptyContentRepository extends StatelessWidget {
  final SelectRepositoryViewModel _viewModel;

  EmptyContentRepository(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Select a repository",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.blue[2],
          fontSize: 32.0,
        ),
      ),
    );
  }
}