import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;

  RepositoryItem(this.repository);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SourceColors.background_grey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        title: Text(
          repository.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          repository.workDirectory,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
