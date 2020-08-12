import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:google_fonts/google_fonts.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;

  RepositoryItem(this.repository);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 86,
      margin: const EdgeInsets.only(left: 8.0, top: 1.0, right: 8.0, bottom: 1.0,),
      decoration: BoxDecoration(
          color: SourceColors.grey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("images/logo-grey.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: VerticalDivider(
              color: SourceColors.grey[5],
              width: 2
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                repository.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  color: SourceColors.blue[2],
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                repository.workDirectory,
                style: GoogleFonts.roboto(
                  color: SourceColors.blue[2],
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
