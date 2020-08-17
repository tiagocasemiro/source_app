import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class RepositoryDetails extends StatelessWidget {
  final Repository _repository;

  RepositoryDetails(this._repository);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
              color: SourceColors.grey[2],
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(_repository.name,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: SourceColors.blue[2],
              fontSize: 23.0,
            ),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\n\$ git status",
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w700,
                  color: SourceColors.blue[2],
                  fontSize: 20.0,
                ),
              ),
              Text(_repository.status,
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
